package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import java.io.FileNotFoundException;
/**
 * 
 * @author Zachary Scurlock
 *	
 * Tests the Reseller class
 */
class ResellerTest {

	@Test
	void testWho() {
		Town test = new Town(6,9);
		test.grid[1][1] = new Reseller(test, 1, 1);
		
		assertEquals(State.RESELLER, test.grid[1][1].who());
	}
	
	@Test
	void testNext() {
		try {
			Town test = new Town("ISP4x4.txt");
			assertEquals(State.EMPTY, test.grid[0][1].next(test).who());
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
	}

}
