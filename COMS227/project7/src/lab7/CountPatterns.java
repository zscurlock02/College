package lab7;

public class CountPatterns {
	public static void main(String[] args) {
		System.out.println(countPatterns(100));
	}
	public static int countPatterns(int n) {
		if (n == 1) {
			return 1;
		}
		if (n == 2) {
			return 1;
		}
		if (n == 3) {
			return 2;
		}
		else {
			return countPatterns(n - 3) + countPatterns(n - 1);
		}
	}
}
