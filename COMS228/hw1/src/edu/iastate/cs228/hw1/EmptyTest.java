package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;
import java.io.FileNotFoundException;
import org.junit.jupiter.api.Test;
/**
 *  @author Zachary Scurlock
 *	Tests the Empty class
 */
class EmptyTest {

	@Test
	void testWho() {
		Town test = new Town(6,9);
		test.grid[1][1] = new Empty(test, 1, 1);
		
		assertEquals(State.EMPTY, test.grid[1][1].who());
	}
	
	@Test
	void testNext() {
		try {
			Town test = new Town("ISP4x4.txt");
			assertEquals(State.CASUAL, test.grid[1][0].next(test).who());
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
	}

}
