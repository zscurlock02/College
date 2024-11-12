package edu.iastate.cs228.hw2;

import java.io.FileNotFoundException;
import java.lang.NumberFormatException; 
import java.lang.IllegalArgumentException; 
import java.util.InputMismatchException;

/**
 *  
 * @author
 * Zachary Scurlock
 *
 */

/**
 * 
 * This class implements the mergesort algorithm.   
 *
 */

public class MergeSorter extends AbstractSorter
{
	
	/** 
	 * Constructor takes an array of points.  It invokes the superclass constructor, and also 
	 * set the instance variables algorithm in the superclass.
	 *  
	 * @param pts   input array of integers
	 */
	public MergeSorter(Point[] pts) 
	{
		super(pts);
		algorithm = "mergesort";
	}


	/**
	 * Perform mergesort on the array points[] of the parent class AbstractSorter. 
	 * 
	 */
	@Override 
	public void sort()
	{
		mergeSortRec(points);
	}

	
	/**
	 * This is a recursive method that carries out mergesort on an array pts[] of points. One 
	 * way is to make copies of the two halves of pts[], recursively call mergeSort on them, 
	 * and merge the two sorted subarrays into pts[].   
	 * 
	 * @param pts	point array 
	 */
	private void mergeSortRec(Point[] pts)
	{
		if(pts.length < 2) {
			return;
		}
		int mid = pts.length / 2;
		Point[] left = new Point[mid];
		Point[] right = new Point[pts.length - mid];
		
		for(int i = 0; i < mid; i++) {											//lines 57 through 72 split up the array recursively 
			left[i] = pts[i];
		}
		for(int i = mid; i < pts.length; i++) {
			right[i - mid] = pts[i];
		}
		
		mergeSortRec(left);
		mergeSortRec(right);
		
		int i = 0;
		int j = 0;
		int k = 0;
		
		while((i < mid) && (j < pts.length - mid)) {
			if(pointComparator.compare(left[i], right[j]) == -1) {
				pts[k] = left[i];
				k++;
				i++;
			}
			else {
				pts[k] = right[j];											   //lines 74 through 100 merge the separate chunks together in order
				k++;
				j++;
			}
		}
		
		while(i < mid) {
			pts[k] = left[i];
			k++;
			i++;
		}
		
		while(j < pts.length - mid) {
			pts[k] = right[j];
			k++;
			j++;
		}
	}

	
	// Other private methods if needed ...

}
