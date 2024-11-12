package lab7;

public class DivideAndConquer {
	public static void main(String[] args)
	  {
	    int[] test = {3, 4, -84, 68, 75, 3, 74, 100}; 
	    System.out.println(largest(test, 0, test.length - 1));
	    System.out.println("Should be 75");
	    System.out.println(pyramidBalls(7));
	    System.out.print("Should be 140 (with pyramid height of 7)"); 
	  }
	public static int largest(int[] arr, int start, int end) {
		if (start == end)
	    {
			return arr[start];
	    }
	    else
	    {
	    	int mid = (start + end) / 2;
	    	return Math.max(largest(arr, start, mid), largest(arr, mid + 1, end));
	    }
	}
	public static int pyramidBalls(int height) {
		if(height == 1) {
			return 1;
		}
		else {
			return height * height + (pyramidBalls(height - 1));
		}
	}
}
