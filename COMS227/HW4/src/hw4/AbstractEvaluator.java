package hw4;
import api.IEvaluator;

import java.util.ArrayList;
import api.Card;
import api.Hand;
import api.IEvaluator;
import util.SubsetFinder;

/**
 * The class AbstractEvaluator includes common code for all evaluator types.
 * 
 * AbstractEvaluator takes care of getRanking, handSize, getName, cardsRequired,
 * canSubsetSatisfy, createHand, and getBestHand. All of the evaluators use a constructor
 * to give needed values to the AbstractEvaluator.
 * 
 * @author Zachary Scurlock
 */
public abstract class AbstractEvaluator implements IEvaluator {
	
	/**
	 * holds the ranking of an evaluator.
	 */
	private int ranking;
	
	/**
	 * holds the handSize of an evaluator.
	 */
	private int handSize;
	
	/**
	 * holds the cardsRequired of an evaluator.
	 */
	private int cardsRequired;
	
	/**
	 * holds the name of an evaluator.
	 */
	private String name;
	
	/**
	 * Constructor for AbstractEvaluator class.
	 * @param ranking
	 *   ranking for the evaluator
	 * @param handSize
	 *   handSize for the evaluator
	 * @param cardsRequired
	 *   cardsRequired for the evaluator
	 * @param name
	 *   name of the evaluator
	 */
	protected AbstractEvaluator(int ranking, int handSize, int cardsRequired, String name) {
		this.ranking = ranking;
		this.handSize = handSize;
		this.cardsRequired = cardsRequired;
		this.name = name;
	}
	
	@Override
	public int getRanking() {
		return ranking;
	}
	
	@Override  
	public int handSize() {
		return handSize;
	}
	
	@Override
	public String getName() {
		return name;
	}
	
	@Override  
	public int cardsRequired() {
		return cardsRequired;
	}
	
	@Override
	public boolean canSubsetSatisfy(Card[] allCards) {
		ArrayList<int[]> indexArrays = SubsetFinder.findSubsets(allCards.length, cardsRequired);
		int i, j;
		Card[] subset = new Card[cardsRequired];
		for(i = 0; i < indexArrays.size(); ++i) {				//finds and tests all possible subsets of cards and if one of the subsets satisfies the evaluator, return true
			int[] indices = indexArrays.get(i);												
			for(j = 0; j < cardsRequired; ++j) {
				subset[j] = allCards[indices[j]];
			}
			if(canSatisfy(subset)) {
				return true;
			}
		}
		return false;
	}
	
	@Override  
	public Hand createHand(Card[] allCards, int[] subset) {
		if(allCards.length < handSize) {													
			return null;
		}
		int i, j;
		ArrayList<Card> cardList = new ArrayList<Card>();
		Card[] main = new Card[subset.length];												//initializes card list and main/side arrays
		Card[] side = new Card[handSize - subset.length];
		for(i = 0; i < allCards.length; ++i) {
			cardList.add(allCards[i]);														//adds all cards to ArrayList
		}
		j = 0;
		for(i = 0; i < subset.length; ++i) {
			main[i] = allCards[subset[i]];													//adds the given indices of cards to the main array and remove those cards from the list
			cardList.remove(subset[i] - j);
			++j;
		}
		if(!canSatisfy(main)) {															//if the main array can't satisfy the evaluator, return null
			return null;
		}
		int count = 0;
		i = 0;
		while(handSize - main.length > count) {											//add the rest of the first cards in the ArrayList to the side array up to the handSize
			side[i] = cardList.get(i);
			++count;
			++i;
		}
		return new Hand(main, side, this);													//returns a hand with the main cards, side cards, and this evaluator
	}
	
	@Override  
	public Hand getBestHand(Card[] allCards) {
		if(!canSubsetSatisfy(allCards)) {
			return null;
		}
		ArrayList<int[]> indexArrays = SubsetFinder.findSubsets(allCards.length, cardsRequired);
		ArrayList<Hand> allHands = new ArrayList<Hand>();
		int i;
		for(i = 0; i < indexArrays.size(); ++i) {											//creates all possible hands of cards using findSubsets
			if(createHand(allCards, indexArrays.get(i)) != null) {
				allHands.add(createHand(allCards, indexArrays.get(i)));
			}
		}
		Hand best = allHands.get(0);
		for(i = 1; i < allHands.size(); ++i) {												//compares all hands to find the best one
			if(best.compareTo(allHands.get(i)) > 0) {
				best = allHands.get(i);
			}
		}
		return best;																		//returns the best hand
	}
}
