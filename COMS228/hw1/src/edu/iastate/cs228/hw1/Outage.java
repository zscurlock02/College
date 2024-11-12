package edu.iastate.cs228.hw1;
/**
 *  @author Zachary Scurlock
 *	Outage class follows the rules of the neighborhood changing elements of the array as needed
 */
public class Outage extends TownCell{

	public Outage(Town p, int r, int c) {
		super(p, r, c);
	}

	@Override
	public State who() {
		return State.OUTAGE;
	}

	@Override
	public TownCell next(Town tNew) {
		return new Empty(tNew, this.row, this.col);
	}

}
