package lab2;

/**
 * A RabbitModel is used to simulate the growth
 * of a population of rabbits. 
 */

public class RabbitModel3
{
  private int rabbitPop;
  /**
   * Constructs a new RabbitModel.
   */
  public RabbitModel3()
  {
   rabbitPop = 0;
  }  
 
  /**
   * Returns the current number of rabbits.
   * @return
   *   current rabbit population
   */
  public int getPopulation()
  {
	
    // TODO - returns a dummy value so code will compile
    return rabbitPop;
  }
  
  /**
   * Updates the population to simulate the
   * passing of one year.
   */
  public void simulateYear() {
	 rabbitPop ++; 
	 rabbitPop = rabbitPop % 5; 
  }
  
  
  /**
   * Sets or resets the state of the model to the 
   * initial conditions.
   */
  public void reset()
  {
	  rabbitPop = 0; 
  }
 
}