package edu.iastate.cs228.hw1;

/**
 * 
 * @author Zachary Scurlock
 * The TownCell class determines if elements of the array are a Reseller, Empty, Casual, Outage, or a Streamer
 *
 */
public abstract class TownCell {

	protected Town plain;
	protected int row;
	protected int col;
	
	
	// constants to be used as indices.
	protected static final int RESELLER = 0;
	protected static final int EMPTY = 1;
	protected static final int CASUAL = 2;
	protected static final int OUTAGE = 3;
	protected static final int STREAMER = 4;
	
	public static final int NUM_CELL_TYPE = 5;
	
	//Use this static array to take census.
	public static final int[] nCensus = new int[NUM_CELL_TYPE];

	public TownCell(Town p, int r, int c) {
		plain = p;
		row = r;
		col = c;
	}
	
	/**
	 * Checks all neighborhood cell types in the neighborhood.
	 * Refer to homework PDF for neighbor definitions (all adjacent
	 * neighbors excluding the center cell).
	 * Use who() method to get who is present in the neighborhood
	 *  
	 * @param counts of all customers
	 */
	public void census(int nCensus[]) {
		// zero the counts of all customers
		nCensus[RESELLER] = 0; 
		nCensus[EMPTY] = 0; 
		nCensus[CASUAL] = 0; 
		nCensus[OUTAGE] = 0; 
		nCensus[STREAMER] = 0; 

		int i = 0;
		int j = 0;
		
		for(i = 0; i < plain.getLength(); i++) {                                                         //iterates through the length and width of array
			for(j = 0; j < plain.getWidth(); j++) {
				boolean neighbor = false;
				if((i - 1 == row || i + 1 == row || i == row) && (j + 1 == col || j - 1 == col)) {       //Checks surrounding area for neighbor
					neighbor = true;
				}
				else if((i + 1 == row || i - 1 == row) && (j - 1 == col || j + 1 == col || j == col)) {  //Checks surrounding area for neighbor
					neighbor = true;
				}
				if(neighbor) {
					if(plain.grid[i][j].who() == State.RESELLER) {
						nCensus[RESELLER]++;															 //if equals reseller, reseller +1
					}
					if(plain.grid[i][j].who() == State.EMPTY) {
						nCensus[EMPTY]++;																 //if equals empty, empty +1
					}
					if(plain.grid[i][j].who() == State.CASUAL) {
						nCensus[CASUAL]++;                                                               //if equals casual, casual +1
					}
					if(plain.grid[i][j].who() == State.OUTAGE) {
						nCensus[OUTAGE]++;																 //if equals outage, outage +1
					}
					if(plain.grid[i][j].who() == State.STREAMER) {
						nCensus[STREAMER]++;															 //if equals streamer, streamer +1
					}
				}
			}
		}
	}

	/**
	 * Gets the identity of the cell.
	 * 
	 * @return State
	 */
	public abstract State who();

	/**
	 * Determines the cell type in the next cycle.
	 * 
	 * @param tNew: town of the next cycle
	 * @return TownCell
	 */
	public abstract TownCell next(Town tNew);
}
