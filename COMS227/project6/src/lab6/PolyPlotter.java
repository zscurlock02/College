package lab6;

import java.awt.Point;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

import plotter.Plotter;
import plotter.Polyline;

public class PolyPlotter {
	public static void main(String[] args) throws FileNotFoundException {
	    ArrayList<Polyline> list = readFile("hello.txt");
	    Plotter plotter = new Plotter();

	    for (Polyline p : list)
	    {
	      plotter.plot(p);
	    }
	}
	
	private static Polyline parseOneLine(String line) {
		Scanner temp = new Scanner(line);
		Polyline pl = new Polyline("red");
		if (temp.hasNextInt()) {
			int width = temp.nextInt();
			pl = new Polyline(temp.next(), width);
		}
		if (!temp.hasNextInt()) {
			pl = new Polyline(temp.next());
		}
		while (temp.hasNextInt()) {
			pl.addPoint(new Point(temp.nextInt(), temp.nextInt()));
		}
		temp.close();
		return pl;
	}
	
	private static ArrayList<Polyline> readFile(String filename) throws FileNotFoundException {
		ArrayList<Polyline> lines = new ArrayList<>();
		File file = new File(filename);
		Scanner scanner = new Scanner(file);
		while (scanner.hasNextLine()) {
			String line = scanner.nextLine();
			line.trim();
			if (line.length() > 0) {
				if (line.charAt(0) != '#') {
					Polyline p = parseOneLine(line);
					lines.add(p);
				}
			}
		}
		scanner.close();
		return lines;
	}
}
