package hw4;
import api.Card;
/**
 * Evaluator for a hand containing (at least) three cards of the same rank.
 * The number of cards required is three.
 * 
 * The name of this evaluator is "Three of a Kind".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class ThreeOfAKindEvaluator extends AbstractEvaluator
{
  /**
   * Constructs the evaluator.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   */
  public ThreeOfAKindEvaluator(int ranking, int handSize)
  {
    super(ranking, handSize, 3, "Three of a Kind");
  }
  @Override
  public boolean canSatisfy(Card[] mainCards) {
	  if(mainCards.length != cardsRequired()) {									//tests if amount of cards is the number of cards required
		  return false;
	  }
	  
	  int i, j;
	  int count = 0;
	  
	  for(i = 0; i < mainCards.length; i++) {
		  count = 1;
		  for(j = 0; j < mainCards.length; j++) {
			  if(j != i) {
				  if(mainCards[i].getRank() == mainCards[j].getRank()) {		//counts all cards with same rank
					  count++;
				  }
			  }
		  }
		  if(count >= 3) {														//returns true if three or more cards are of equal rank
			  return true;
		  }
	  }
	  return false;
  }
}
