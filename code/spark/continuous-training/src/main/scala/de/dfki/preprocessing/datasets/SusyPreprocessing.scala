package de.dfki.preprocessing.datasets

import de.dfki.preprocessing.Preprocessor
import de.dfki.preprocessing.parsers.CSVParser
import de.dfki.utils.CommandLineParser
import org.apache.spark.{SparkConf, SparkContext}

/**
  * @author behrouz
  */
object SusyPreprocessing {
  val INPUT_PATH = "data/susy/raw"
  val OUTPUT_PATH = "data/susy-test"
  val FILE_COUNT = 100
  val SAMPLING_RATE = 1.0

  def main(args: Array[String]): Unit = {
    val parser = new CommandLineParser(args).parse()
    val conf = new SparkConf().setAppName("Susy Data Preprocessing")
    val masterURL = conf.get("spark.master", "local[*]")
    conf.setMaster(masterURL)
    val sc = new SparkContext(conf)

    val dataParser = new CSVParser()
    val input = parser.get("input-path", INPUT_PATH)
    val output = parser.get("output-path", OUTPUT_PATH)
    val fileCount = parser.getInteger("file-count", FILE_COUNT)
    val samplingRate = parser.getDouble("sampling-rate", SAMPLING_RATE)

    val data = if (samplingRate < 1.0 )
      sc.textFile(input).map(dataParser.parsePoint)
      .sample(withReplacement = false, fraction = samplingRate, seed = 42)
    else
      sc.textFile(input).map(dataParser.parsePoint)

    val preprocessor = new Preprocessor()
    val scaledData = preprocessor.scale(data)
    val splits = preprocessor.split(scaledData, Array(0.1,0.9))
    preprocessor.convertToCSV(splits._1).repartition(sc.defaultParallelism).saveAsTextFile(s"$output/initial-training/")
    preprocessor.convertToCSV(splits._2.repartition(fileCount)).saveAsTextFile(s"$output/stream-training/")
  }

}
