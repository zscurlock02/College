package edu.iastate.cs228.hw2;

/**
 *  
 * @author
 * Zachary Scurlock
 *
 */

/**
 * 
 * This class executes four sorting algorithms: selection sort, insertion sort, mergesort, and
 * quicksort, over randomly generated integers as well integers from a file input. It compares the 
 * execution times of these algorithms on the same input. 
 *
 */

import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.Random; 


public class CompareSorters 
{
	/**
	 * Repeatedly take integer sequences either randomly generated or read from files. 
	 * Use them as coordinates to construct points.  Scan these points with respect to their 
	 * median coordinate point four times, each time using a different sorting algorithm.  
	 * 
	 * @param args
	 **/
	public static void main(String[] args) throws FileNotFoundException
	{		
		System.out.println("keys: 1 (random integers) 2 (file input) 3 (exit)");
		int userSelection = 1;
		int trial = 1;
		Scanner scnr = new Scanner(System.in);
		Random rand = new Random();
		PointScanner[] scanners = new PointScanner[4]; 
		
		while(userSelection == 1|| userSelection == 2) {
			System.out.print("Trial " + trial + ": ");
			userSelection = scnr.nextInt();
			if(userSelection == 1) {													// If userSelection is 1 then the program will prompt the user to enter the number of random points they want
				System.out.print("Enter number of random points: ");
				int randPoints = scnr.nextInt();
				Point[] points;
				try {
					points = generateRandomPoints(randPoints, rand);
				} 
				catch(Exception e) {
					System.out.println("Invalid input, please try again");				// If the number of random points is invalid the user will be prompted to try again
					continue;
				}
				scanners[0] = new PointScanner(points, Algorithm.SelectionSort);
				scanners[1] = new PointScanner(points, Algorithm.InsertionSort);
				scanners[2] = new PointScanner(points, Algorithm.MergeSort);
				scanners[3] = new PointScanner(points, Algorithm.QuickSort);
				System.out.println("\nalgorithm   size  time (ns)\n----------------------------------");
				for(int i = 0; i < 4; i++) {
					scanners[i].scan();
					System.out.println(scanners[i].stats());
				}
				System.out.println("----------------------------------\n");
				trial++;
			}
			if(userSelection == 2) {
				System.out.print("File name: ");
				String fileName = scnr.next();
				try {
					scanners[0] = new PointScanner(fileName, Algorithm.SelectionSort);
					scanners[1] = new PointScanner(fileName, Algorithm.InsertionSort);
					scanners[2] = new PointScanner(fileName, Algorithm.MergeSort);
					scanners[3] = new PointScanner(fileName, Algorithm.QuickSort);
				}
				catch(FileNotFoundException e) {
					System.out.println("File not found, please try again");
					continue;
				}
				catch(InputMismatchException e) {
					System.out.println("Ensure the file has an even number of integers");
					continue;
				}
				System.out.println("\nalgorithm   size  time (ns)\n----------------------------------");
				for(int i = 0; i < 4; i++) {
					scanners[i].scan();
					System.out.println(scanners[i].stats());
				}
				System.out.println("----------------------------------");
				trial++;
			}
		}
		scnr.close();
	}
	
	
	/**
	 * This method generates a given number of random points.
	 * The coordinates of these points are pseudo-random numbers within the range 
	 * [-50,50] × [-50,50]. Please refer to Section 3 on how such points can be generated.
	 * 
	 * Ought to be private. Made public for testing. 
	 * 
	 * @param numPts  	number of points
	 * @param rand      Random object to allow seeding of the random number generator
	 * @throws IllegalArgumentException if numPts < 1
	 */
	public static Point[] generateRandomPoints(int numPts, Random rand) throws IllegalArgumentException
	{ 
		if(numPts < 1) {
			throw new IllegalArgumentException();
		}
		Point[] points = new Point[numPts];
		for(int i = 0; i < numPts; i++) {
			points[i] = new Point(rand.nextInt(101) - 50, rand.nextInt(101) - 50);
		}
		return points;
	}
	
}
