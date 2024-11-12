import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Arrays;

import org.junit.Test;

import api.Card;
import api.IEvaluator;
import hw4.AllPrimesEvaluator;
import hw4.CatchAllEvaluator;
import hw4.FourOfAKindEvaluator;
import hw4.FullHouseEvaluator;
import hw4.OnePairEvaluator;
import hw4.StraightEvaluator;
import hw4.StraightFlushEvaluator;
import hw4.ThreeOfAKindEvaluator;

/**
 * 
 * @author svyatoslavvarnitskyy
 *
 */

public class HW4SpecCheckFunctionalTests {
	
	@Test
	public void testAllPrimeName() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		try {
			assertEquals("All Primes", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: All Primes name incorrect exctected: All Primes    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testAllPrimeHandSize() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		try {
		assertEquals(4, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: All Primes handSize incorrect expected: 4      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testAllPrimecanSatisfy() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: All Primes canSatisfy with cards [2c, 3d, 5h, 7] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testAllPrimecanSubsetSatisfy() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: All Primes canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testAllPrimecanSatisfy2() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: All Primes canSatisfy with cards [Ah, 4d, 7c, 8s] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testAllPrimecanSubsetSatisfy2() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: All Primes canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Qh, Ks] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testAllPrimebestHand() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh");
		Arrays.sort(cards);
		try {
		assertEquals("All Primes (1) [Kh Js 7d 5h]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: All Primes bestHand with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh] expected: All Primes (1) [Kh Js 7d 5h]  Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testAllPrimebestHand2() {
		IEvaluator eval = new AllPrimesEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: All Primes bestHand with cards [Ah, 4d, 7c, 8s, Qh, Ks] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	
	
	
	
	
	
	
	@Test
	public void testOnePairName() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		try {
			assertEquals("One Pair", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: One Pair name incorrect expected: One Pair    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testOnePairHandSize() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		try {
		assertEquals(4, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: One Pair handSize incorrect expected: 4      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testOnePaircanSatisfy() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		Card[] cards = Card.createArray("3c, 3d");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: One Pair canSatisfy with cards [3c, 3d] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testOnePaircanSubsetSatisfy() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: One Pair canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testOnePaircanSatisfy2() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: One Pair canSatisfy with cards [Ah, 4d, 7c, 8s] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testOnePaircanSubsetSatisfy2() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: One Pair canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Qh, Ks] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testOnePairbestHand() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d");
		Arrays.sort(cards);
		try {
		assertEquals("One Pair (1) [6h 6c : Kh Qh]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: One Pair bestHand with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d] expected: One Pair (1) [6h 6c : Kh Qh]  Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testOnePairbestHand2() {
		IEvaluator eval = new OnePairEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: One Pair bestHand with cards [Ah, 4d, 7c, 8s, Qh, Ks] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	
	
	
	
	
	
	@Test
	public void testThreeOfAKindName() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		try {
			assertEquals("Three of a Kind", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind name incorrect expected: Three of a Kind    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testThreeOfAKindHandSize() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		try {
		assertEquals(4, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind handSize incorrect expected: 4      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testThreeOfAKindcanSatisfy() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		Card[] cards = Card.createArray("Kh, Kc, Ks");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind canSatisfy with cards [Kh, Kc, Ks] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testThreeOfAKindcanSubsetSatisfy() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Kc, Ks");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: Three of a Kind canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Kc, Ks] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testThreeOfAKindcanSatisfy2() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		Card[] cards = Card.createArray("8s, Kh, Kc");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind canSatisfy with cards [8s, Kh, Kc] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testThreeOfAKindcanSubsetSatisfy2() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, Kh");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Qh, Ks, Kh] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testThreeOfAKindbestHand() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		Card[] cards = Card.createArray("2c, 3s, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, Ks, Kc");
		Arrays.sort(cards);
		try {
		assertEquals("Three of a Kind (1) [Ks Kh Kc : Qh]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind bestHand with cards [2c, 3s, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, Ks, Kc] expected: Three of a Kind (1) [Ks Kh Kc : Qh]  Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testThreeOfAKindbestHand2() {
		IEvaluator eval = new ThreeOfAKindEvaluator(1, 4);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Three of a Kind bestHand with cards [Ah, 4d, 7c, 8s, Qh, Ks, Kc] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	
	
	
	
	
	@Test
	public void testFourOfAKindName() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		try {
			assertEquals("Four of a Kind", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind name incorrect expected: Four of a Kind    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testFourOfAKindHandSize() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		try {
		assertEquals(5, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind handSize incorrect expected: 5      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testFourOfAKindcanSatisfy() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		Card[] cards = Card.createArray("9h, 9c, 9d, 9s");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind canSatisfy with cards [9h, 9c, 9d, 9s] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testFourOfAKindcanSubsetSatisfy() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, 9h, 9c, 9d, 9s");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: Four of a Kind canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, 9h, 9c, 9d, 9s] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testFourOfAKindcanSatisfy2() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		Card[] cards = Card.createArray("Ah, 9h, 9c, 9d");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind canSatisfy with cards [Ah, 9h, 9c, 9d] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testFourOfAKindcanSubsetSatisfy2() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, 9h, 9c, 9d");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Qh, Ks, 9h, 9c, 9d] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testFourOfAKindbestHand() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		Card[] cards = Card.createArray("2c, 3d, 3s, 3h, 3c, 9h, 9c, 9d, 9d");
		Arrays.sort(cards);
		try {
		assertEquals("Four of a Kind (1) [9h 9d 9d 9c : 3s]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind bestHand with cards [2c, 3d, 3s, 3h, 3c, 9h, 9c, 9d, 9d] expected: Four of a Kind (1) [9h 9d 9d 9c : 3s]  Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testFourOfAKindbestHand2() {
		IEvaluator eval = new FourOfAKindEvaluator(1, 5);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, 9c, 9d, 9d");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Four of a Kind bestHand with cards [Ah, 4d, 7c, 8s, Qh, Ks, 9c, 9d, 9d] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	


	
	
	
	
	
	
	
	@Test
	public void testCatchAllName() {
		IEvaluator eval = new CatchAllEvaluator(1, 5);
		try {
			assertEquals("Catch All", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: Catch All name incorrect expected: Catch All    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testCatchAllHandSize() {
		IEvaluator eval = new CatchAllEvaluator(1, 5);
		try {
		assertEquals(5, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: Catch All handSize incorrect expected: 5      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testCatchAllcanSatisfy() {
		IEvaluator eval = new CatchAllEvaluator(1, 5);
		Card[] cards = Card.createArray("Ac, 2h, 4d, 5s, 9h");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Catch All canSatisfy with cards [Ac, 2h, 4d, 5s, 9h] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testCatchAllcanSubsetSatisfy() {
		IEvaluator eval = new CatchAllEvaluator(1, 5);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, 9h, 9c, 9d, 9s");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: Catch All canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, 9h, 9c, 9d, 9s] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	

	
	
	
	
	
	
	
	
	@Test
	public void testStraightName() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		try {
			assertEquals("Straight", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: Straight name incorrect expected: Straight    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testStraightHandSize() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		try {
		assertEquals(5, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: Straight handSize incorrect expected: 5      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testStraightcanSatisfy() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2s, 3h, 4c, 5s");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Straight canSatisfy with cards [Ah, 2s, 3h, 4c, 5s] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testStraightcanSubsetSatisfy() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Ah, 2s, 3h, 4c, 5s");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: Straight canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Ah, 2s, 3h, 4c, 5s] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testStraightcanSatisfy2() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2s, 3h, 4c, 7h");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Straight canSatisfy with cards [Ah, 2s, 3h, 4c, 7h] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testStraightcanSubsetSatisfy2() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, 9h, 9c, 9d, Ah, 2s, 3h, 4c, 7h");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Straight canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Qh, Ks, 9h, 9c, 9d, Ah, 2s, 3h, 4c, 7h] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testStraightbestHand() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2c, 3h, 4d, 5s, Ah, 4s, 7c, 8s");
		Arrays.sort(cards);
		try {
		assertEquals("Straight (1) [5s 4s 3h 2c Ah]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: (Aces low) Straight bestHand with cards [Ah, 2c, 3h, 4d, 5s, Ah, 4s, 7c, 8s] expected: Straight (1) [5s 4s 3h 2c Ah]  Was: " + eval.getBestHand(cards));
		}
	}
	
	
	@Test
	public void testStraightbestHand2() {
		IEvaluator eval = new StraightEvaluator(1, 5, 14);
		Card[] cards = Card.createArray("Ah, Kh, Ks, Qs, Jc, 10d, 9c");
		Arrays.sort(cards);
		try {
		assertEquals("Straight (1) [Ah Ks Qs Jc 10d]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: (Aces high) Straight bestHand with cards [Ah, Kh, Ks, Qs, Jc, 10d, 9c] expected: Straight (1) [Ah Ks Qs Jc 10d]  Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testStraightbestHand3() {
		IEvaluator eval = new StraightEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, 9c, 9d, 9d");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Straight bestHand with cards [Ah, 4d, 7c, 8s, Qh, Ks, 9c, 9d, 9d] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	@Test
	public void testStraightFlushName() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		try {
			assertEquals("Straight Flush", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: StraightFlush name incorrect expected: Straight Flush    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testStraightFlushHandSize() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		try {
		assertEquals(5, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: StraightFlush handSize incorrect expected: 5      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testStraightFlushcanSatisfy() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2h, 3h, 4h, 5h");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: StraightFlush canSatisfy with cards [Ah, 2h, 3h, 4h, 5h] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testStraightFlushcanSubsetSatisfy() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Ah, 2h, 3h, 4h, 5h");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: StraightFlush canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Ah, 2h, 3h, 4h, 5h] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testStraightFlushcanSatisfy2() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2h, 3h, 4h, 5c");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: StraightFlush canSatisfy with cards [Ah, 2h, 3h, 4h, 5c] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testStraightFlushcanSubsetSatisfy2() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Ah, 2h, 3h, 4h, 5c");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: StraightFlush canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Ah, 2h, 3h, 4h, 5c] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testStraightFlushbestHand() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2h, 3h, 4h, 5h, As, 4s, 7c, 8s");
		Arrays.sort(cards);
		try {
		assertEquals("Straight Flush (1) [5h 4h 3h 2h Ah]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: (Aces low) StraightFlush bestHand with cards [Ah, 2h, 3h, 4h, 5h, As, 4s, 7c, 8s] expected: Straight Flush (1) [5h 4h 3h 2h Ah]  Was: " + eval.getBestHand(cards));
		}
	}
	
	
	@Test
	public void testStraightFlushbestHand2() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 14);
		Card[] cards = Card.createArray("As, Ks, Kc, Qs, Js, 10s, 9s");
		Arrays.sort(cards);
		try {
		assertEquals("Straight Flush (1) [As Ks Qs Js 10s]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: (Aces high) StraightFlush bestHand with cards [Ah, Kh, Ks, Qs, Jc, 10d, 9c] expected: Straight Flush (1) [As Ks Qs Js 10s] Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testStraightFlushbestHand3() {
		IEvaluator eval = new StraightFlushEvaluator(1, 5, 13);
		Card[] cards = Card.createArray("Ah, 2c, 3h, 4d, 5s, Ah, 4s, 7c, 8s");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: StraightFlush bestHand with cards [Ah, 2c, 3h, 4d, 5s, Ah, 4s, 7c, 8s] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	
	
	
	
	
	
	@Test
	public void testFullHouseName() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		try {
			assertEquals("Full House", eval.getName());
		}catch (AssertionError e) {
			System.out.println("Error: Full House name incorrect expected: Full House    Was: " + eval.getName());
		}
		
	}
	
	@Test
	public void testFullHouseHandSize() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		try {
		assertEquals(5, eval.handSize());
		}catch (AssertionError e) {
			System.out.println("Error: Full House handSize incorrect expected: 5      Was: " + eval.handSize());
		}
	}
	
	@Test
	public void testFullHousecanSatisfy() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		Card[] cards = Card.createArray("9h, 9c, 9d, 3c, 3c");
		Arrays.sort(cards);
		try {
		assertEquals(true , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Full House canSatisfy with cards [9h, 9c, 9d, 3c, 3c] expected: true      Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testFullHousecanSubsetSatisfy() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		Card[] cards = Card.createArray("2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, 9h, 9c, 9d, 9s");
		Arrays.sort(cards);
		try {
			assertEquals(true , eval.canSubsetSatisfy(cards));
		} catch (AssertionError e) {
			System.out.println("Error: Full House canSubsetSatisfy with cards [2c, 3d, 5h, 7d, 6h, Js, 6c, Kh, Qh, 3c, 3d, 9h, 9c, 9d, 9s] expected: true      Was: " + eval.canSubsetSatisfy(cards));
		}
		
	}
	
	@Test
	public void testFullHousecanSatisfy2() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		Card[] cards = Card.createArray("Ah, 9h, 9c, 9d, 9s");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Full House canSatisfy with cards [Ah, 9h, 9c, 9d, 9s] expected: false     Was: " + eval.canSatisfy(cards));
		}
	}
	
	@Test
	public void testFullHousecanSubsetSatisfy2() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, 9h, 9c, 9d, 9s");
		Arrays.sort(cards);
		try {
		assertEquals(false , eval.canSubsetSatisfy(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Full House canSubsetSatisfy with cards [Ah, 4d, 7c, 8s, Qh, Ks, 9h, 9c, 9d, 9s] expected: false     Was: " + eval.canSubsetSatisfy(cards));
		}
	}
	
	@Test
	public void testFullHousebestHand() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		Card[] cards = Card.createArray("2c, 2c, 9h, 9c, 9s, 4s, 4d, 2s");
		Arrays.sort(cards);
		try {
		assertEquals("Full House (1) [9s 9h 9c 4s 4d]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: Full House bestHand(hand: 5) with cards [2c, 2c, 9h, 9c, 9s, 4s, 4d, 2s] expected: Full House (1) [9s 9h 9c 4s 4d]  Was: " + eval.getBestHand(cards));
		}
	}
	
	
	@Test
	public void testFullHousebestHand3() {
		IEvaluator eval = new FullHouseEvaluator(1, 6);
		Card[] cards = Card.createArray("2c, 2c, 9h, 9c, 9s, 4s, 4d, 2s");
		Arrays.sort(cards);
		try {
		assertEquals("Full House (1) [9s 9h 9c 2s 2c 2c]", eval.getBestHand(cards).toString());
		}catch (AssertionError e) {
			System.out.println("Error: Full House bestHand(hand: 6) with cards [2c, 2c, 9h, 9c, 9s, 4s, 4d, 2s] expected: Full House (1) [9s 9h 9c 2s 2c 2c]  Was: " + eval.getBestHand(cards));
		}
	}
	
	@Test
	public void testFullHousebestHand2() {
		IEvaluator eval = new FullHouseEvaluator(1, 5);
		Card[] cards = Card.createArray("Ah, 4d, 7c, 8s, Qh, Ks, 9c, 9d, 9d");
		Arrays.sort(cards);
		try {
		assertEquals(null , eval.getBestHand(cards));
		}catch (AssertionError e) {
			System.out.println("Error: Full House bestHand with cards [Ah, 4d, 7c, 8s, Qh, Ks, 9c, 9d, 9d] expected: null   Was: " + eval.getBestHand(cards));
		}
	}
	
	
	
	
	
	
	
	
	
	
	

	

}
