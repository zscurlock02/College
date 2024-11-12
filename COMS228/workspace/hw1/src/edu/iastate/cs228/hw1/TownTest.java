package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;
import java.io.FileNotFoundException;
import org.junit.jupiter.api.Test;
/**
 * 
 * @author Zachary Scurlock
 *	
 * Tests the Town class
 */
class TownTest {

	@Test
	void testTown() {
		try {
			Town test = new Town("ISP4x4.txt");
			assertEquals(State.OUTAGE, test.grid[0][0].who());
			assertEquals(State.RESELLER, test.grid[0][1].who());
			assertEquals(State.OUTAGE, test.grid[0][2].who());
			assertEquals(State.RESELLER, test.grid[0][3].who());
			assertEquals(State.EMPTY, test.grid[1][0].who());
			assertEquals(State.EMPTY, test.grid[1][1].who());
			assertEquals(State.CASUAL, test.grid[1][2].who());
			assertEquals(State.OUTAGE, test.grid[1][3].who());
			assertEquals(State.EMPTY, test.grid[2][0].who());
			assertEquals(State.STREAMER, test.grid[2][1].who());
			assertEquals(State.OUTAGE, test.grid[2][2].who());
			assertEquals(State.STREAMER, test.grid[2][3].who());
			assertEquals(State.EMPTY, test.grid[3][0].who());
			assertEquals(State.OUTAGE, test.grid[3][1].who());
			assertEquals(State.RESELLER, test.grid[3][2].who());
			assertEquals(State.RESELLER, test.grid[3][3].who());
		}
		catch(FileNotFoundException E){
			fail("No file found");
		}
	}
	@Test
	void testGetWidth() {
		Town test = new Town(4,4);
		assertEquals(4, test.getWidth());
	}
	@Test
	void testGetLength() {
		Town test = new Town(4,4);
		assertEquals(4, test.getLength());
	}
	@Test
	void testRandomInit() {
		Town test = new Town(2, 2);
		test.randomInit(1234);
		for(int i = 0; i < test.getLength(); i++) {
			for(int j = 0; j < test.getWidth(); j++) {
				if(test.grid[i][j].who() == State.CASUAL || test.grid[i][j].who() == State.EMPTY || test.grid[i][j].who() == State.RESELLER || test.grid[i][j].who() == State.STREAMER || test.grid[i][j].who() == State.OUTAGE) {
					assertTrue(true);
				} 
			}
		}	
	}
	@Test
	void testToString() {
		try {
			Town test = new Town("ISP4x4.txt");
			String sTest = "O R O R\nE E C O\nE S O S\nE O R R";
			assertEquals(sTest, test.toString());
		}
		catch (FileNotFoundException E) {
			fail("No file found");
		}
	}

}
