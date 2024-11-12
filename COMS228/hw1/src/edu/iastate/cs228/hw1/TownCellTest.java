package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;
import java.io.FileNotFoundException;
import org.junit.jupiter.api.Test;
/**
 * 
 * @author Zachary Scurlock
 *	
 * Tests the TownCell class
 */
class TownCellTest {

	@Test
	void testCensus() {
		try {
			Town test = new Town("ISP4x4.txt");
			int[] nCensus = new int[5];
			test.grid[0][0].census(nCensus);
			assertEquals(1, nCensus[0]);
			assertEquals(2, nCensus[1]);
			assertEquals(0, nCensus[2]);
			assertEquals(0, nCensus[3]);
			assertEquals(0, nCensus[4]);
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
	}

}
