package lab3;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Before;
import balloon3.Balloon;

public class BalloonTests {
	private Balloon b;
	private static final double EPSILON = 10e-07;
	
	@Before
	public void testInitial() {
		b = new Balloon(10);
	}
	@Test
	public void testBlow() {
		b.blow(3);
		b.blow(5);
		assertEquals(8.0, b.getRadius(), EPSILON);
	}
	@Test
	public void testDeflate() {
		b.deflate();
		assertEquals(false, b.isPopped());
	}
	@Test
	public void testGetRadius() {
		b.deflate();
		assertEquals(0, b.getRadius());
	}
	@Test
	public void testIsPopped() {
		b.pop();
		b.blow(5);
		assertEquals(0, b.getRadius());
	}
	@Test
	public void testPop() {
		b.pop();
	    assertEquals(0.0, b.getRadius(), EPSILON);
	}

}
