import scala.util.matching.Regex
import java.nio.file.{Paths, Files}
import java.nio.charset.StandardCharsets


class ParseTime (val timeString: String) {
  var _diff = 0
  val timePattern: Regex = raw"[0-9]+\. [a-zA-Z]+ \d{2}, (\d{2}):(\d{2}) - (\d{2}):(\d{2})\s*([0-9].*)?\s*".r

  def show(): String = {
    timeString match {
      case timePattern(_, _, _, _, e) => {
        if (e == null || e == "")
          timeString + " " + diff().toString
        else
          timeString
      }
      case _ => timeString
    }
  }

  def diff(): Int = {
    timeString match {
      case timePattern(a, b, c, d, _) => {
        val h1 = a.toInt; var h2 = c.toInt
        val m1 = b.toInt; val m2 = d.toInt

        if (h1 > h2) h2 += 24
        _diff = m2 - m1 + (h2 - h1)*60
        _diff
      }
      case _ => 0
    }
  }
}

object ParseTime {
  def main(args : Array[String]) : Unit = {
    args match {
      case Array(filename) => {
        val lines = scala.io.Source.fromFile(filename).mkString
        val newLines = lines.split("\n").map(new ParseTime(_)).map(_.show()).mkString("\n")
        Files.write(Paths.get(filename), newLines.getBytes(StandardCharsets.UTF_8))
      }
      case Array(filename, _) => {
        val lines = scala.io.Source.fromFile(filename).mkString
        val sum = lines.split("\n").map(new ParseTime(_)).map(_.diff()).sum
        println(sum)
      }
      case _ => 
    }
  }
}
