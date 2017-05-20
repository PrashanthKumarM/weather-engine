/* Reference taken from cloudera word count*/
/* this is test code to test reading from file system as an arument, later the code will be modified to write storm detection algorithm*/
package src.main.scala.com.sga.sparkwordcount
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object SparkWordCount {
  def main(args: Array[String]) {
  val sc = new SparkContext(new SparkConf().setAppName("Spark Count"))
  val tokenized = sc.textFile(args(0))

      System.out.println("Predicted: no storm")
        }
        }