package edu.iastate.cs228.hw1;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;

/**
 * @author Zachary Scurlock
 *
 * The ISPBusiness class performs simulation over a grid 
 * plain with cells occupied by different TownCell types.
 *
 */
public class ISPBusiness {
	
	/**
	 * Returns a new Town object with updated grid value for next billing cycle.
	 * @param tOld: old/current Town object.
	 * @return: New town object.
	 */
	public static Town updatePlain(Town tOld) {
		Town tNew = new Town(tOld.getLength(), tOld.getWidth());
		for(int i = 0; i < tOld.getLength(); i++) {
			for(int j = 0; j < tOld.getWidth(); j++) {
				tNew.grid[i][j] = tOld.grid[i][j].next(tNew);
			}
		}
		return tNew;
	}
	
	/**
	 * Returns the profit for the current state in the town grid.
	 * @param town
	 * @return
	 */
	public static int getProfit(Town town) {
		int i = 0;
		int j = 0;
		int profit = 0;
		
		for(i = 0; i < town.getLength(); i++) {
			for(j = 0; j < town.getWidth(); j++) {
				if(town.grid[i][j].who() == State.CASUAL) {
					profit += 1;
				}
			}
		}
		return profit;
	}

	

	/**
	 *  Main method. Interact with the user and ask if user wants to specify elements of grid
	 *  via an input file (option: 1) or wants to generate it randomly (option: 2).
	 *  
	 *  Depending on the user choice, create the Town object using respective constructor and
	 *  if user choice is to populate it randomly, then populate the grid here.
	 *  
	 *  Finally: For 12 billing cycle calculate the profit and update town object (for each cycle).
	 *  Print the final profit in terms of %. You should print the profit percentage
	 *  with two digits after the decimal point:  Example if profit is 35.5600004, your output
	 *  should be:
	 *
	 *	35.56%
	 *  
	 * Note that this method does not throw any exception, so you need to handle all the exceptions
	 * in it.
	 * 
	 * @param args
	 * 
	 */
	public static void main(String []args) {
		int input = 0;
		int i = 0;
		int row, col, seed;
		String fileDirectory = "";
		Scanner scnr = new Scanner(System.in);
		System.out.println("How to populate grid (type 1 or 2): 1: from a file. 2: randomly with seed");
		while(input != 1 && input != 2) {
			input = scnr.nextInt();
			if(input != 1 && input != 2) {
				System.out.println("Please try again.");
			}
		}
		Town t = new Town(1,1);
		if(input == 1) {
			System.out.println("Please enter file path: ");
			while(i < 1) {
				try {
					fileDirectory = scnr.next();
					t = new Town(fileDirectory);
					i++;
				}
				catch(FileNotFoundException E) {
					System.out.println("File not found, please try again.");
				}
			}
		}
		if(input == 2) {
			System.out.println("Provide rows, cols and seed integer separated by spaces: ");
			row = scnr.nextInt();
			col = scnr.nextInt();
			seed = scnr.nextInt();
			t = new Town(row, col);
			t.randomInit(seed);
		}
		
		double possibleProfit = t.getLength() * t.getWidth() * 12.0;
		double totalProfit = 0.0;
		
		ArrayList<Town> aList = new ArrayList<Town>();
		
		aList.add(t);
		
		for(i = 0; i < 11; i++) {
			aList.add(updatePlain(aList.get(i)));
		}
		
		for(i = 0; i < aList.size(); i++) {
			totalProfit += getProfit(aList.get(i));
		}
		
		double profitPercentage = (totalProfit / possibleProfit) * 100.0; //Calculates percent difference between total profit and possible profit
		System.out.printf("%.2f" , profitPercentage); 					  //Prints the difference up to 2 decimal places	
		System.out.print("%");
	}
}
