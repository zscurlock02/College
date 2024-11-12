package hw4;
import api.Card;
/**
 * Evaluator for a generalized full house.  The number of required
 * cards is equal to the hand size.  If the hand size is an odd number
 * n, then there must be (n / 2) + 1 cards of the matching rank and the
 * remaining (n / 2) cards must be of matching rank. In this case, when constructing
 * a hand, the larger group must be listed first even if of lower rank
 * than the smaller group</strong> (e.g. as [3 3 3 5 5] rather than [5 5 3 3 3]).
 * If the hand size is even, then half the cards must be of matching 
 * rank and the remaining half of matching rank.  Any group of cards,
 * all of which are the same rank, always satisfies this
 * evaluator.
 * 
 * The name of this evaluator is "Full House".
 * @author Zachary Scurlock
 */
//Note: You must edit this declaration to extend AbstractEvaluator
//or to extend some other class that extends AbstractEvaluator
public class FullHouseEvaluator extends AbstractEvaluator
{
  /**
   * Constructs the evaluator.
   * @param ranking
   *   ranking of this hand
   * @param handSize
   *   number of cards in a hand
   */
  public FullHouseEvaluator(int ranking, int handSize)
  {
    super(ranking, handSize, handSize, "Full House");
  }
  @Override
	public boolean canSatisfy(Card[] mainCards) {
		boolean isBigDone = false;
		boolean isSmallDone = false;
		boolean isOdd = false;
		boolean isEven = false;
		boolean allSame = true;
		int cardsMatchBig;
		int cardsMatchSmall;
		int halfOfCards;
		int i;
		int count = 0;
		int firstChange = 0;
		
		for(i = 0; i < mainCards.length; ++i) {											//tests to see if all cards are the same
			if (mainCards[0].getRank() != mainCards[i].getRank()) {
				allSame = false;
				break;
			}
		}
		if(allSame) {
			return true;
		}
		
		if(handSize() % 2 == 0) {															//determines if handsize is odd or even
			isEven = true;
		}
		else {
			isOdd = true;
		}
		
		if(isEven) {																		//if handsize is even check to see if there is a full house
			halfOfCards = handSize() / 2;
			
			for (i = 0; i < mainCards.length; ++i) {
				if(mainCards[0].getRank() != mainCards[i].getRank()) {						//find the first change is ranks of cards
					firstChange = i;
					break;
				}
			}
			
			for(i = 0; i < mainCards.length; ++i) {
				if(mainCards[0].getRank() == mainCards[i].getRank()) {						//count how many cards have same rank as first card (should be half)
					++count;
				}
			}
			if(count != halfOfCards) {														//if not half of cards return false
				return false;
			}
			count = 0;
			
			for(i = firstChange; i < mainCards.length; ++i) {								//find length of other matching set
				if(mainCards[firstChange] == mainCards[i]) {
					++count;
				}
			}
			if(count != halfOfCards) {														//if other set is not the whole other half, return false
				return false;
			}
		}
		if(isOdd) {																		//if handsize is odd check to see if there is a full house
			cardsMatchBig = handSize() / 2 + 1;
			cardsMatchSmall = handSize() - cardsMatchBig;
			for(i = 0; i < mainCards.length; ++i) {
				if(mainCards[0].getRank() != mainCards[i].getRank()) {						//find where the cards first change ranks
					firstChange = i;
					break;
				}
			}
			for(i = 0; i < mainCards.length; ++i) {
				if(mainCards[0].getRank() == mainCards[i].getRank()) {						//count how many cards have the same rank starting with the first card
					++count;
				}
			}
			
			if(count == cardsMatchBig) {													//determine if the count is the cards matching for the bigger quantity, the smaller, or neither
				isBigDone = true;
			}
			else if(count == cardsMatchSmall) {
				isSmallDone = true;
			}
			else {
				return false;
			}
			count = 0;
			
			if(isBigDone) {
				for(i = firstChange; i < mainCards.length; ++i) {							//find the length of other match
					if(mainCards[firstChange] == mainCards[i]) {
						++count;
					}
				}
			}
			if(count != cardsMatchSmall) {													//if the length of other match is not equal to other size needed, return false
				return false;
			}
			
			if(isSmallDone) {
				for(i = firstChange; i < mainCards.length; ++i) {							//same thing as above but for other case
					if(mainCards[firstChange] == mainCards[i]) {
						++count;
					}
				}
			}
			if(count != cardsMatchBig) {
				return false;
			}
			
		}
		return true;																		
	}
}
