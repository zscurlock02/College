package edu.iastate.cs228.hw1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Random;
import java.util.Scanner;


/**
 *  @author Zachary Scurlock
 *	The Town class takes arrays from files, as well as generating random arrays
 * 	and determing if the elements of the generated array are 1 of the 5 possible options
 */
public class Town {
	
	private int length, width;  //Row and col (first and second indices)
	public TownCell[][] grid;
	
	/**
	 * Constructor to be used when user wants to generate grid randomly, with the given seed.
	 * This constructor does not populate each cell of the grid (but should assign a 2D array to it).
	 * @param length
	 * @param width
	 */
	public Town(int length, int width) {
		this.length = length;
		this.width = width;
		grid = new TownCell[length][width]; 
	}
	
	/**
	 * Constructor to be used when user wants to populate grid based on a file.
	 * Please see that it simple throws FileNotFoundException exception instead of catching it.
	 * Ensure that you close any resources (like file or scanner) which is opened in this function.
	 * @param inputFileName
	 * @throws FileNotFoundException
	 */
	public Town(String inputFileName) throws FileNotFoundException {
		File file = new File(inputFileName);
		Scanner scnr = new Scanner(file);
		int rows, collumns;
		
		rows = scnr.nextInt();
		collumns = scnr.nextInt();
		length = rows;
		width = collumns;
		
		scnr.nextLine();
		
		grid = new TownCell[rows][collumns];
		
		for(int i = 0; i < rows; i++) {
			for(int j = 0; j < collumns; j++) {
				char c = scnr.next().charAt(0);
				if(c == 'R') {											//if c is equal to R, grid[i][j] becomes a Reseller
					grid[i][j] = new Reseller(this, i, j);
				}
				if(c == 'E') {											//if c is equal to E, grid[i][j] becomes Empty
					grid[i][j] = new Empty(this, i, j);
				}
				if(c == 'C') {											//if c is equal to C, grid[i][j] becomes a Casual
					grid[i][j] = new Casual(this, i, j);
				}
				if(c == 'O') {											//if c is equal to O, grid[i][j] becomes an Outage
					grid[i][j] = new Outage(this, i, j);
				}
				if(c == 'S') {											//if c is equal to S, grid[i][j] becomes a Streamer
					grid[i][j] = new Streamer(this, i, j);
				}
			}
		}
		scnr.close();
	}
	
	/**
	 * Returns width of the grid.
	 * @return
	 */
	public int getWidth() {
		return width;
	}
	
	/**
	 * Returns length of the grid.
	 * @return
	 */
	public int getLength() {
		return length;
	}

	/**
	 * Initialize the grid by randomly assigning cell with one of the following class object:
	 * Casual, Empty, Outage, Reseller OR Streamer
	 */
	public void randomInit(int seed) {
		Random rand = new Random(seed);
		
		int randHolder;
		
		for(int i = 0; i < length; i++) {
			for(int j = 0; j < width; j++) {
				randHolder = rand.nextInt(5);
				if(randHolder == 0) {
					grid[i][j] = new Reseller(this, i, j);
				}
				if(randHolder == 1) {
					grid[i][j] = new Empty(this, i, j);
				}
				if(randHolder == 2) {
					grid[i][j] = new Casual(this, i, j);
				}
				if(randHolder == 3) {
					grid[i][j] = new Outage(this, i, j);
				}
				if(randHolder == 4) {
					grid[i][j] = new Streamer(this, i, j);
				}
			}
		}
	}
	
	/**
	 * Output the town grid. For each square, output the first letter of the cell type.
	 * Each letter should be separated either by a single space or a tab.
	 * And each row should be in a new line. There should not be any extra line between 
	 * the rows.
	 */
	@Override
	public String toString() {
		String s = "";
		for(int i = 0; i < length; i++) {
			for(int j = 0; j < width; j++) {
				if(grid[i][j].who() == State.RESELLER) {
					s += "R";											//If grid[i][j] equals Reseller, R is added to the string
				}
				if(grid[i][j].who() == State.EMPTY) {
					s += "E";											//If grid[i][j] equals Empty, E is added to the string
				}
				if(grid[i][j].who() == State.CASUAL) {					//If grid[i][j] equals Casual, C is added to the string
					s += "C";
				}
				if(grid[i][j].who() == State.OUTAGE) {
					s += "O";											//If grid[i][j] equals Outage, O is added to the string
				}
				if(grid[i][j].who() == State.STREAMER) {
					s += "S";											//If grid[i][j] equals Streamer, S is added to the string
				}
				
				if(j < width - 1) {
					s += " ";
				}
				else if(i < length - 1) {
					s += "\n";
				}
			}
		}
		return s;
	}
}
