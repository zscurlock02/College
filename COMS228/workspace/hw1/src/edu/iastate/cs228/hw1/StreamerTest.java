package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import java.io.FileNotFoundException;
/**
 *  @author Zachary Scurlock
 * 	Tests the Streamer class
 */
class StreamerTest {

	@Test
	void testWho() {
		Town test = new Town(6,9);
		test.grid[1][1] = new Streamer(test, 1, 1);
		
		assertEquals(State.STREAMER, test.grid[1][1].who());
	}
	
	@Test
	void testNext() {
		try {
			Town test = new Town("ISP4x4.txt");
			assertEquals(State.OUTAGE, test.grid[2][3].next(test).who());
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
	}

}
