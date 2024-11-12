package hw4;
import api.Card;
/**
 * Evaluator for a hand containing (at least) two cards of the same rank.
 * The number of cards required is two.
 * 
 * The name of this evaluator is "One Pair".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class OnePairEvaluator extends AbstractEvaluator
{
  /**
   * Constructs the evaluator.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   */
  public OnePairEvaluator(int ranking, int handSize)
  {
	  super(ranking, handSize, 2, "One Pair");
  }
  @Override
  public boolean canSatisfy(Card[] mainCards) {
	  if(mainCards.length == cardsRequired()) {
		  if(mainCards[0].getRank() == mainCards[1].getRank()) {	 //tests if cards given is the same as cards required and cards are of equal rank
		  	return true;											
		  }
	  }
	  return false;
  }
  
}
