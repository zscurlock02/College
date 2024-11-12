package lab2;

import java.util.Random;

/**
 * A RabbitModel is used to simulate the growth
 * of a population of rabbits. 
 */

public class RabbitModel
{
  private int rabbitPop;
  private int lastYear = 1;
  private int yearBefore = 0; 
  /**
   * Constructs a new RabbitModel.
   */
  public RabbitModel()
  {
   rabbitPop = lastYear + yearBefore;
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
	 yearBefore = lastYear;
	 lastYear = rabbitPop;
	 rabbitPop = lastYear + yearBefore;
  }
  
  
  /**
   * Sets or resets the state of the model to the 
   * initial conditions.
   */
  public void reset()
  {
	  lastYear = 1;
	  yearBefore = 0;
	  rabbitPop = lastYear + yearBefore; 
  }
 
}