package edu.iastate.cs228.hw1;
/**
 *  @author Zachary Scurlock
 *	Streamer class follows the rules of the neighborhood changing elements of the array as needed
 */
public class Streamer extends TownCell{

	public Streamer(Town p, int r, int c) {
		super(p, r, c);
	}

	@Override
	public State who() {
		return State.STREAMER;
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
		if(nCensus[OUTAGE] >= 1) {
			return new Empty(tNew, this.row, this.col);
		}
		if(nCensus[CASUAL] >= 5){
			return new Streamer(tNew, this.row, this.col);
		}
		return new Streamer(tNew, this.row, this.col);
	}

}
