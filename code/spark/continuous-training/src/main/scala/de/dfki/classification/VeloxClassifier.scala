package de.dfki.classification

import java.util.concurrent.{Executors, TimeUnit}

import de.dfki.utils.CommandLineParser
import de.dfki.utils.MLUtils._
import org.apache.log4j.Logger
import org.apache.spark.streaming.Seconds

/**
  * Training and Serving of SVM classifier using the architecture described in Velox: https://arxiv.org/abs/1409.3809
  * - Train a model on an initial dataset
  * - 'Deploy' the model and start relieving prediction queries and observations
  * - On prediction queries return the predicted label
  * - On training observations perform incremental update (to maximize throughput, data is arriving in mini batches)
  * - Retrain a model after a while, discard the current model and 'deploy' the new model
  *
  * TODO: This is a hackish solution ... Full implementation should trigger a complete restart of the spark context ..
  * Perform a batch retraining ... store the model and read the model in the streaming as the initial model
  *
  * @author Behrouz Derakhshan
  */
object VeloxClassifier extends SVMClassifier {
  @transient private val logger = Logger.getLogger(getClass.getName)

  /**
    * @param args arguments to the main class should be a set of key, value pairs in the format of key=value
    *             Velox Classifier:
    *             slack: delay between in periodic sgd iteration
    *             temp-path: path to write the observed data for retraining purposed
    *             refer to [[SVMClassifier]] to view the rest of the arguments
    *
    */
  def main(args: Array[String]): Unit = {
    run(args)
  }

  def parseVeloxArgs(args: Array[String]): (Long, Long, String, String, String, String, String) = {
    val parser = new CommandLineParser(args).parse()
    val (batchDuration, resultPath, initialDataPath, streamingDataPath, testDataPath) = parseArgs(args)
    val slack = parser.getLong("slack", defaultTrainingSlack)
    val tempDirectory = parser.get("temp-path", s"$BASE_DATA_DIRECTORY/temp-data")
    (batchDuration, slack, resultPath, initialDataPath, streamingDataPath, testDataPath, experimentResultPath(tempDirectory))
  }

  override def run(args: Array[String]): Unit = {
    val (batchDuration, slack, resultPath, initialDataPath, streamingDataPath, testDataPath, tempDirectory) = parseVeloxArgs(args)
    createTempFolders(tempDirectory)
    val ssc = initializeSpark(Seconds(batchDuration))

    // train initial model
    streamingModel = createInitialStreamingModel(ssc, initialDataPath + "," + tempDirectory)
    val streamingSource = streamSource(ssc, streamingDataPath)
    val testData = constantInputDStreaming(ssc, testDataPath)

    writeStreamToDisk(streamingSource.map(_._2.toString), tempDirectory)

    // evaluate the stream and incrementally update the model
    if (testDataPath == "prequential") {
      evaluateStream(streamingSource.map(_._2.toString).map(parsePoint), resultPath)
      trainOnStream(streamingSource.map(_._2.toString).map(parsePoint))
    } else {
      evaluateStream(testData, resultPath)
      trainOnStream(streamingSource.map(_._2.toString).map(parsePoint))
    }

    // periodically retrain the model from scratch using the historical data
    val task = new Runnable {
      def run() {
        if (ssc.sparkContext.isStopped) {
          future.cancel(true)
        }
        logger.info("initiating a retraining of the model ...")
        println(streamingModel.latestModel().weights.toString)
        streamingSource.pause()

        val startTime = System.currentTimeMillis()
        val model = trainModel(ssc.sparkContext, initialDataPath + "," + tempDirectory, 100)
        val endTime = System.currentTimeMillis()
        storeTrainingTimes(endTime - startTime, resultPath)
        streamingModel.setInitialModel(model)
        logger.info("Model was re-trained ...")


        if (streamingSource.isCompleted()) {
          logger.warn("stopping the program")
          ssc.stop(stopSparkContext = true, stopGracefully = true)
          future.cancel(true)
          execService.shutdown()
        }

        streamingSource.unpause()
      }
    }

    ssc.start()

    execService = Executors.newSingleThreadScheduledExecutor()
    future = execService.scheduleWithFixedDelay(task, slack, slack, TimeUnit.SECONDS)
    future.get()

  }

  override def getApplicationName = "Velox SVM Model"

  override def getExperimentName = "velox"

  override def defaultBatchDuration = 1L

  override def defaultTrainingSlack = 60L
}