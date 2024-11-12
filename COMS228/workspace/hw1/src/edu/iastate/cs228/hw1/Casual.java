package edu.iastate.cs228.hw1;
/**
 *  @author Zachary Scurlock
 *	The Casual class follows the rules of the neighborhood changing elements of the array as needed
 */
public class Casual extends TownCell{

	public Casual(Town p, int r, int c) {
		super(p, r, c);
	}

	@Override
	public State who() {
		return State.CASUAL;
	}

	@Override
	public TownCell next(Town tNew) {
		census(nCensus); 
		if(nCensus[EMPTY] + nCensus[OUTAGE] <= 1) {
			return new Reseller(tNew, this.row, this.col);
		}
		if(nCensus[RESELLER] >= 1) {
			return new Outage(tNew, this.row, this.col);
		}
		if(nCensus[STREAMER] >= 1) {
			return new Streamer(tNew, this.row, this.col);
		}
		if(nCensus[CASUAL] >= 5){
			return new Streamer(tNew, this.row, this.col);
		}
		return new Casual(tNew, this.row, this.col);
	}

}
