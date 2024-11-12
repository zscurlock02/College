package edu.iastate.cs228.hw1;
/**
 *  @author Zachary Scurlock
 *	The Reseller class follows the rules of the neighborhood changing elements of the array as needed
 */

public class Reseller extends TownCell{

	public Reseller(Town p, int r, int c) {
		super(p, r, c);
	}

	@Override
	public State who() {
		return State.RESELLER;
	}

	@Override
	public TownCell next(Town tNew) {
		census(nCensus); 
		if(nCensus[CASUAL] <= 3) {
			return new Empty(tNew, this.row, this.col);
		}
		if(nCensus[EMPTY] >= 3) {
			return new Empty(tNew, this.row, this.col);
		}
		if(nCensus[CASUAL] >= 5){
			return new Streamer(tNew, this.row, this.col);
		}
		return new Reseller(tNew, this.row, this.col);
	}

}
