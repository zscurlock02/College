package hw4;
import api.Card;
/**
 * Evaluator for a hand containing (at least) four cards of the same rank.
 * The number of cards required is four.
 * 
 * The name of this evaluator is "Four of a Kind".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class FourOfAKindEvaluator extends AbstractEvaluator
{
  /**
   * Constructs the evaluator.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   */
  public FourOfAKindEvaluator(int ranking, int handSize)
  {
    super(ranking, handSize, 4, "Four of a Kind");
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
				  if(mainCards[i].getRank() == mainCards[j].getRank()) {		//counts number of cards with same rank
					  count++;
				  }
			  }
		  }
		  if(count >= 4) {														//returns true if four or more cards are of equal rank
			  return true;
		  }
	  }
	  return false;
  }

}
