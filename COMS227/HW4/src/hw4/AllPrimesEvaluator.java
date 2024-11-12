package hw4;
import api.Card;
/**
 * Evaluator for a hand in which the rank of each card is a prime number.
 * The number of cards required is equal to the hand size. 
 * 
 * The name of this evaluator is "All Primes".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class AllPrimesEvaluator extends AbstractEvaluator
{
  /**
   * Constructs the evaluator.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   */
  public AllPrimesEvaluator(int ranking, int handSize)
  {
    super(ranking, handSize, handSize, "All Primes");
  }
  @Override
  public boolean canSatisfy(Card[] mainCards) {
	  if(mainCards.length != cardsRequired()) { //tests if amount of cards is the number of cards required
		  return false;
	  }
	  int i;
	  
	  for(i = 0; i < mainCards.length; i++) {	//tests to ensure all cards are prime numbers (maxes at 13)
		  if(mainCards[i].getRank() != 2 && mainCards[i].getRank() != 3 && mainCards[i].getRank() != 5 && mainCards[i].getRank() != 7 && mainCards[i].getRank() != 11 && mainCards[i].getRank() != 13) {
			  return false;
		  }
	  }
	  return true;
  }
}
