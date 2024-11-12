package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import java.io.FileNotFoundException;
/**
 * 
 * @author Zachary Scurlock
 *	
 * Tests the Outage class
 */
class OutageTest {

	@Test
	void testWho() {
		Town test = new Town(6,9);
		test.grid[1][1] = new Outage(test, 1, 1);
		
		assertEquals(State.OUTAGE, test.grid[1][1].who());
	}
	
	@Test
	void testNext() {
		try {
			Town test = new Town("ISP4x4.txt");
			assertEquals(State.EMPTY, test.grid[0][0].next(test).who());
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
	}

}
