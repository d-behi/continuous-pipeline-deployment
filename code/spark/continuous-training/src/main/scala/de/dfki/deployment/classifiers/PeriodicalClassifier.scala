package de.dfki.deployment.classifiers

import java.io.{File, FileWriter}

import de.dfki.core.scheduling.{FixedIntervalScheduler, FolderBasedScheduler}
import de.dfki.utils.CommandLineParser

/**
  * Training and Serving of a classifier using the architecture described in Velox: https://arxiv.org/abs/1409.3809
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
object PeriodicalClassifier extends Classifier {
  var slack: Long = _
  var incremental: Boolean = _

  /**
    * @param args arguments to the main class should be a set of key, value pairs in the format of key=value
    *             Velox Classifier:
    *             slack: delay between in periodic sgd iteration
    *             refer to [[Classifier]] to view the rest of the arguments
    *
    */
  def main(args: Array[String]): Unit = {
    run(args)
  }

  override def parseArgs(args: Array[String]) = {
    super.parseArgs(args)
    val parser = new CommandLineParser(args).parse()
    slack = parser.getLong("slack", defaultTrainingSlack)
    incremental = parser.getBoolean("incremental", default = true)
  }

  override def run(args: Array[String]): Unit = {
    parseArgs(args)
    var testType = ""
    if (evaluationDataPath == "prequential") {
      testType = "prequential"
    } else {
      testType = "dataset"
    }
    val child = s"$getExperimentName/model-type-$modelType/num-iterations-$numIterations/" +
      s"slack-$slack/updater-$updater/step-size-$stepSize/"

    val resultPath = experimentResultPath(resultRoot, child)
    if (pipelinePath == DEFAULT_MODEL_PATH) {
      pipelinePath = s"$resultRoot/$child/model"
    }
    val ssc = initializeSpark()

    // train initial model
    val startTime = System.currentTimeMillis()

    val data = ssc.sparkContext
      .textFile(initialDataPath)
      .repartition(ssc.sparkContext.defaultParallelism)

    val pipeline = trainInitialPipeline(ssc, data)
    val endTime = System.currentTimeMillis()
    storeTrainingTimes(endTime - startTime, resultPath)

    val streamingSource = streamSource(ssc, streamingDataPath)
    val testData = ssc.sparkContext.textFile(evaluationDataPath)

    evaluateStream(pipeline, testData, testData, resultPath)
    streamingSource
      .map(_._2.toString)
      // dummy action
      .foreachRDD(_ => dummyAction())

    // periodically retrain the model from scratch using the historical data
    val task = new Runnable {
      def run() {
        //println(streamingModel.latestModel().weights.toString)
        streamingSource.pause()
        val startTime = System.currentTimeMillis()
        val data = ssc.sparkContext.textFile(initialDataPath + "," + streamingSource.getProcessedFiles.mkString(","))
        val pipeline = trainInitialPipeline(ssc, data)
        val endTime = System.currentTimeMillis()
        evaluateStream(pipeline, testData, testData, resultPath)
        storeTrainingTimes(endTime - startTime, resultPath)
        streamingSource.resume()
      }
    }

    // slack == -1 means a Folder based Scheduler
    val scheduler = if (slack == -1) {
      new FolderBasedScheduler(streamingSource, ssc, task)
    } else {
      new FixedIntervalScheduler(streamingSource, ssc, task, slack)
    }

    ssc.start()
    scheduler.init()
    scheduler.schedule()
    ssc.awaitTermination()

  }

  def storeRetrainingPoint(index: Int, resultPath: String) = {
    val file = new File(s"$resultPath/retraining-points.txt")
    file.getParentFile.mkdirs()
    val fw = new FileWriter(file, true)
    fw.write(s"$index\n")
    fw.close()
  }

  override def getApplicationName = "Velox Classifer"

  override def getExperimentName = "velox"

  override def defaultBatchDuration = 1L

  override def defaultTrainingSlack = 60L

  override def defaultModelType = "svm"
}