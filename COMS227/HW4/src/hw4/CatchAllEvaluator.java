package hw4;
import api.Card;
/**
 * Evaluator satisfied by any set of cards.  The number of
 * required cards is equal to the hand size.
 * 
 * The name of this evaluator is "Catch All".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class CatchAllEvaluator extends AbstractEvaluator
{
  /**
   * Constructs the evaluator.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   */
  public CatchAllEvaluator(int ranking, int handSize)
  {
    super(ranking, handSize, handSize, "Catch All");
  }
  @Override
  public boolean canSatisfy(Card[] mainCards) {
	  if(mainCards.length != cardsRequired()) {		//tests if amount of cards is the number of cards required
		  return false;
	  }
	  return true;
  }
}
