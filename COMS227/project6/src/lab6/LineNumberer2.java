package lab6;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class LineNumberer2
{
  public static void main(String[] args) throws FileNotFoundException
  {
    File file = new File("../project4/src/lab4/Donuts.java");
    Scanner scanner = new Scanner(file);
    int lineCount = 1;

    while (scanner.hasNextLine())
    {
      String line = scanner.nextLine();
      System.out.print(lineCount + " ");
      System.out.println(line);
      lineCount += 1;
    }
    scanner.close();
    System.out.println();
    numberOfWords();
  }
  private static void numberOfWords() throws FileNotFoundException {
	  File story = new File("story.txt");
	  Scanner scnr = new Scanner(story);
	  int words = 0;
	  String[] amount;
	  String line = new String();
	  while(scnr.hasNextLine()) {
		  line = scnr.nextLine();
		  amount = line.split("\\s+");
		  words = amount.length;
		  if(amount[0] == "") {
			  words -= 1;
		  }
		  System.out.println(line + "   |   Words: " + words);
	  }
	  scnr.close();
  }
}
