package hw4;

import api.Card;
import api.Suit;

/**
 * Evaluator for a hand consisting of a "straight" in which the
 * card ranks are consecutive numbers AND the cards all
 * have the same suit.  The number of required 
 * cards is equal to the hand size.  An ace (card of rank 1) 
 * may be treated as the highest possible card or as the lowest
 * (not both) To evaluate a straight containing an ace it is
 * necessary to know what the highest card rank will be in a
 * given game; therefore, this value must be specified when the
 * evaluator is constructed.  In a hand created by this
 * evaluator the cards are listed in descending order with high 
 * card first, e.g. [10 9 8 7 6] or [A K Q J 10], with
 * one exception: In case of an ace-low straight, the ace
 * must appear last, as in [5 4 3 2 A]
 * 
 * The name of this evaluator is "Straight Flush".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class StraightFlushEvaluator extends AbstractEvaluator
{
	/*
	 * holds maximum card rank
	 */
	private int maxCardRank;
  /**
   * Constructs the evaluator. Note that the maximum rank of
   * the cards to be used must be specified in order to 
   * correctly evaluate a straight with ace high.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   * @param maxCardRank
   *   largest rank of any card to be used
   */
  public StraightFlushEvaluator(int ranking, int handSize, int maxCardRank)
  {
	  super(ranking, handSize, handSize, "Straight Flush");
	  this.maxCardRank = maxCardRank;
  }
	
  @Override
  public boolean canSatisfy(Card[] mainCards) {			//Similar to StraightEvaluator but this checks if all suits are the same
	  int i;
	  boolean aceLow = false;
	  boolean aceHigh = false;
	  int mainCardsLength = mainCards.length - 1;
	  
	  if(maxCardRank < 13) {
		if(mainCards[0].getRank() == 1) {
			aceLow = true;
		}
		if(aceLow) {
			for(i = 1; i < mainCardsLength; ++i) {
				if(mainCards[i].getRank() != mainCards[i + 1].getRank() + 1 && mainCards[0].getSuit() != mainCards[i].getSuit()) {
					return false;
				}
			}
			if(mainCards[mainCardsLength].getRank() != 2) {
				return false;
			}
		}
		else {
			for(i = 0; i < mainCardsLength; ++i) {
				if(mainCards[i].getRank() != mainCards[i + 1].getRank() + 1 && mainCards[0].getSuit() != mainCards[i].getSuit()) {
					return false;
				}
			}
		}
	  }
	  else if(maxCardRank == 13) {
		  if(mainCards[0].getRank() == 1) {
			aceHigh = true;
		  }
		  if(aceHigh) {
			for(i = 1; i < mainCardsLength; ++i) {
				if(i == 1) {
					if (mainCards[i].getRank() != 13) {
						return false;
					}
				}
				if(mainCards[i].getRank() != mainCards[i + 1].getRank() + 1 && mainCards[0].getSuit() != mainCards[i].getSuit()) {
					return false;
				}
			}
		  }
		  else {
			for(i = 0; i < mainCardsLength; ++i) {
				if(mainCards[i].getRank() != mainCards[i + 1].getRank() + 1 && mainCards[0].getSuit() != mainCards[i].getSuit()) {
					return false;
				}
			}
		  }
	  }
	  return true;
  }
}
