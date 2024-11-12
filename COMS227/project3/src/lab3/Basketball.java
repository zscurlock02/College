package lab3;

public class Basketball {
	
	private double diameter;
	private boolean inflationStatus;
	
	public Basketball(double givenDiameter){
		diameter = givenDiameter;
		inflationStatus = false; 
	  }

	  public boolean isDribbleable(){
		  
	    return inflationStatus;
	  }

	  public double getDiameter(){
		  
	    return diameter;
	  }

	  public double getCircumference(){
		  
	    return 0;
	  }

	  public void inflate(){
		  inflationStatus = true;
	  }
}
