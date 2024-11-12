package edu.iastate.cs228.hw1;

import static org.junit.jupiter.api.Assertions.*;
import java.io.FileNotFoundException;
import org.junit.jupiter.api.Test;
/**
 * 
 * @author Zachary Scurlock
 *	
 * Tests the ISPBusiness class
 */
class ISPBusinessTest {

	@Test
	void testUpdatePlain() {
		try {
			Town test = new Town("ISP4x4.txt");
			Town test2 = ISPBusiness.updatePlain(test);
			assertEquals(State.EMPTY, test2.grid[0][0].who());
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
	}
	@Test
	void testGetProfit() {
		try {
			Town test = new Town("ISP4x4.txt");
			assertEquals(1, ISPBusiness.getProfit(test));
		}
		catch(FileNotFoundException E) {
			fail("No file found");
		}
		
	}

}
