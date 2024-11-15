package edu.iastate.cs228.hw2;

/**
 * 
 * @author 
 * Zachary Scurlock
 *
 */

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;
import java.io.FileWriter;
/**
 * 
 * This class sorts all the points in an array of 2D points to determine a reference point whose x and y 
 * coordinates are respectively the medians of the x and y coordinates of the original points. 
 * 
 * It records the employed sorting algorithm as well as the sorting time for comparison. 
 *
 */
public class PointScanner  
{
	private Point[] points; 
	
	private Point medianCoordinatePoint;  // point whose x and y coordinates are respectively the medians of 
	                                      // the x coordinates and y coordinates of those points in the array points[].
	private Algorithm sortingAlgorithm;    
	
		
	protected long scanTime; 	       // execution time in nanoseconds. 
	
	/**
	 * This constructor accepts an array of points and one of the four sorting algorithms as input. Copy 
	 * the points into the array points[].
	 * 
	 * @param  pts  input array of points 
	 * @throws IllegalArgumentException if pts == null or pts.length == 0.
	 */
	public PointScanner(Point[] pts, Algorithm algo) throws IllegalArgumentException
	{
		if(pts == null || pts.length == 0) {
			throw new IllegalArgumentException();
		}
		sortingAlgorithm = algo;
		points = new Point[pts.length];
		for(int i = 0; i < pts.length; i++) {
			points[i] = pts[i];
		}
	}

	
	/**
	 * This constructor reads points from a file. 
	 * 
	 * @param  inputFileName
	 * @throws FileNotFoundException 
	 * @throws InputMismatchException   if the input file contains an odd number of integers
	 */
	protected PointScanner(String inputFileName, Algorithm algo) throws FileNotFoundException, InputMismatchException
	{
		File file = new File(inputFileName);
		Scanner scnr = new Scanner(file);
		int xVal = 0;
		int yVal = 0;
		int k = 0;
		int sizeOfInput = 0;
		ArrayList<Point> a = new ArrayList<Point>(); 
		sortingAlgorithm = algo;
		
		while(scnr.hasNextInt()) {
			if(k == 0) {
				xVal = scnr.nextInt();
				sizeOfInput++;
				k = 1;
			}
			else if(k == 1) {
				yVal= scnr.nextInt();
				sizeOfInput++;
				k = 2;
			}
			else if(k == 2) {
				Point p = new Point(xVal, yVal);
				a.add(p);
				k = 0;
			}
		}
		scnr.close();
		
		if((sizeOfInput % 2) == 1) {
			throw new InputMismatchException();
		}
		points = new Point[a.size()];
		
		for(int i = 0; i < points.length; i++) {
			points[i] = a.get(i);
		}
	}

	
	/**
	 * Carry out two rounds of sorting using the algorithm designated by sortingAlgorithm as follows:  
	 *    
	 *     a) Sort points[] by the x-coordinate to get the median x-coordinate. 
	 *     b) Sort points[] again by the y-coordinate to get the median y-coordinate.
	 *     c) Construct medianCoordinatePoint using the obtained median x- and y-coordinates.     
	 *  
	 * Based on the value of sortingAlgorithm, create an object of SelectionSorter, InsertionSorter, MergeSorter,
	 * or QuickSorter to carry out sorting.       
	 * @param algo
	 * @return
	 */
	public void scan() { 
		AbstractSorter aSorter; 
		
		if(sortingAlgorithm == Algorithm.SelectionSort) {
			aSorter = new SelectionSorter(points);
		}
		else if(sortingAlgorithm == Algorithm.InsertionSort) {
			aSorter = new InsertionSorter(points);
		}
		else if(sortingAlgorithm == Algorithm.QuickSort) {
			aSorter = new QuickSorter(points);
		}
		else {
			aSorter = new MergeSorter(points);
		}
		
		aSorter.setComparator(0);
		long timeBegin = System.nanoTime();
		aSorter.sort();
		long timeTotal = System.nanoTime() - timeBegin;
		int x = aSorter.getMedian().getX();
		
		if(sortingAlgorithm == Algorithm.SelectionSort) {
			aSorter = new SelectionSorter(points);
		}
		else if(sortingAlgorithm == Algorithm.InsertionSort) {
			aSorter = new InsertionSorter(points);
		}
		else if(sortingAlgorithm == Algorithm.QuickSort) {
			aSorter = new QuickSorter(points);
		}
		else {
			aSorter = new MergeSorter(points);
		}
		
		aSorter.setComparator(1);
		timeBegin = System.nanoTime();
		aSorter.sort();
		timeTotal += (System.nanoTime() - timeBegin);
		int y = aSorter.getMedian().getY();
		
		medianCoordinatePoint = new Point(x, y);
		scanTime = timeTotal;
	}
	
	
	/**
	 * Outputs performance statistics in the format: 
	 * 
	 * <sorting algorithm> <size>  <time>
	 * 
	 * For instance, 
	 * 
	 * selection sort   1000	  9200867
	 * 
	 * Use the spacing in the sample run in Section 2 of the project description. 
	 */
	public String stats()
	{
		String algo;
		if(sortingAlgorithm == Algorithm.SelectionSort) {
			algo = "SelectionSort   ";
		}
		else if(sortingAlgorithm == Algorithm.InsertionSort) {
			algo = "InsertionSort   ";
		}
		else if(sortingAlgorithm == Algorithm.MergeSort) {
			algo = "MergeSort       ";
		}
		else {
			algo = "QuickSort       ";
		}
		return algo + String.format("%8d", points.length) + String.format("%10d", scanTime);
	}
	
	
	/**
	 * Write MCP after a call to scan(),  in the format "MCP: (x, y)"   The x and y coordinates of the point are displayed on the same line with exactly one blank space 
	 * in between. 
	 */
	@Override
	public String toString()
	{
		return "MCP: (" + medianCoordinatePoint.getX() + ", " + medianCoordinatePoint.getY() + ")";
	}

	
	/**
	 *  
	 * This method, called after scanning, writes point data into a file by outputFileName. The format 
	 * of data in the file is the same as printed out from toString().  The file can help you verify 
	 * the full correctness of a sorting result and debug the underlying algorithm. 
	 * 
	 * @throws FileNotFoundException
	 */
	public void writeMCPToFile() throws FileNotFoundException
	{
		try {
			FileWriter w = new FileWriter(sortingAlgorithm.toString() + ".txt");
			w.close();
		}
		catch(IOException a) {
			System.out.println("An error has occured");
			a.printStackTrace();
		}
	}
}

