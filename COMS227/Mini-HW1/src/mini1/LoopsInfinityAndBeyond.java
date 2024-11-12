package mini1;

import java.util.Scanner;

/**
 * Utility class with a bunch of static methods for loop practice.
 * @author
 */
public class LoopsInfinityAndBeyond {

	// disable instantiation
	private LoopsInfinityAndBeyond() { }
	
	/**
	 * Returns a new string in which every character in the given string that
	 * is not already repeated consecutively is doubled.
	 * <p> 
	 * For example:
	 * <pre>{@code
	 * "attribute1" -> "aattrriibbuuttee11"
	 * "AAA Bonds" -> "AAA  BBoonnddss"
	 * }</pre>
	 * 
	 * @param text given starting string
	 * @return string with characters doubled
	 */
	public static String doubleChars(String text)
	{
		int i;
		String result = "";
		if (text.length() == 1) {
			result = result + text.charAt(0) + text.charAt(0);
			return result;
		}
		for (i = 0; i < text.length(); ++i) {
			
			if (i == 0) {
				if (text.charAt(i) != text.charAt(i + 1)) {
					result = result + text.charAt(i) + text.charAt(i);
				}
				else {
					result = result + text.charAt(i);
				}
			}
			
			if (i > 0 && i <= text.length() - 2) {
				if(text.charAt(i) != text.charAt(i + 1) && text.charAt(i) != text.charAt(i - 1)) {
					result = result + text.charAt(i) + text.charAt(i);
				}
				else {
					result = result + text.charAt(i);
				}
			}
			
			if (i == text.length() - 1) {
				if (text.charAt(i) != text.charAt(i - 1)) {
					result = result + text.charAt(i) + text.charAt(i);
				}
				else {
					result = result + text.charAt(i);
				}
			}
		}
		return result;
	}

	/**
	 * Returns a year with the highest value, given a string containing pairs
	 * of years and values (doubles). If there are no pairs, the method returns
	 * -1. In the case of a tie, the first year with the highest value is
	 * returned. Assumes the given string follows the correct format.
	 * <p>
	 * For example, given the following string, the year 1995 is returned.
	 * <pre>
	 * 1990 75.6 1991 110.6 1995 143.6 1997 62.3
	 * </pre>
	 * 
	 * @param data given string containing year-value pairs
	 * @return first year associated with the highest value, or -1 if no pair
	 *         given
	 */
	public static int maxYear(String data)
	{
		data.trim();
		String[] num = data.split(" ");
		
		if (num.length <= 1) {
			return -1;
		}
		
		int maxYear;
		double maxVal;
		int i;
		
		maxYear = Integer.parseInt(num[0]);
		maxVal = Double.parseDouble(num[1]);
		
		for (i = 3; i < num.length; i += 2) {
			if (Double.parseDouble(num[i]) > maxVal) {
				maxVal = Double.parseDouble(num[i]);
				maxYear = Integer.parseInt(num[i - 1]);
			}
		}
		
		return maxYear;
	}
	
	/**
	 * Returns the number of iterations required until <code>n</code> is equal to 1,
	 * where each iteration updates <code>n</code> in the following way:
	 * 
	 * <pre>
	 *     if n is even
	 *         divide it in half
	 *     else
	 *         multiply n by three and add 1
	 * </pre>
	 * 
	 * For example, given <code>n == 6</code>, the successive values of
	 * <code>n</code> would be 3, 10, 5, 16, 8, 4, 2, 1, so the method returns 8. If
	 * <code>n</code> is less than 1, the method returns -1.
	 * <p>
	 * <em>(Remark:</em> How do we know this won't be an infinite loop for some
	 * values of <code>n</code>? In general, we don't: in fact this is a well-known
	 * open problem in mathematics. However, it has been checked for numbers up to
	 * 10 billion, which covers the range of possible values of the Java
	 * <code>int</code> type.)
	 * 
	 * @param n given starting number
	 * @return number of iterations required to reach <code>n == 1</code>, or -1 if
	 *         <code>n</code> is not positive
	 */
	public static int collatzspacerer(int n)
	{
		int spacer = 0;
		if(n <= 0) {
			return -1;
		}
		
		while(n != 0) {
			if(n % 2 == 0) {
				n = n / 2;
				spacer++;
			}
			else {
				n = n * 3 + 1;
				spacer++;
			}
		}
		return spacer;
	}
	
	/**
	 * Returns a new string in which every word in the given string is doubled. A
	 * word is defined as a contiguous group of non-space (i.e., ' ') characters
	 * that starts with an alphabetic letter and are surrounded by spaces and/or
	 * the start or end of the given string. Assumes the given string does not
	 * contain more than one consecutive white-space.
	 * <p> 
	 * For example:
	 * <pre>{@code
	 * "the time time" -> "the the time time time time"
	 * "The answer is 42." -> "The The answer answer is is 42."
	 * "A. runtime = 10ms" -> "A. A. runtime runtime = 10ms"
	 * }</pre>
	 * 
	 * @param text given starting string
	 * @return new string in which words are doubled
	 */
	public static String doubleWords(String text)
	{
		int i;
		if (text.length() == 0) {
			return "";
		}
		String words[] = text.split(" ");
		String result = "";
		for (i = 0; i < words.length; ++i) {
			if (i != 0) {
				if(Character.isAlphabetic(words[i].charAt(0))) {
					result = result + " " + words[i] + " " + words[i];
				}
				else {
					result = result + " " + words[i];
				}
			}
			else if (i == 0) {
				if(Character.isAlphabetic(words[i].charAt(0))) {
					result = result + words[i] + " " + words[i];
				}
				else {
					result = result + words[i];
				}
			}
		}
		return result;

	}

	/**
	 * Returns true if string t can be obtained from string s by removing exactly
	 * one vowel character. The vowels are the letters 'a', 'e', 'i', 'o'
	 * and 'u'. Vowels can be matched in either upper or lower case, for example,
	 * 'A' is treated the same as 'a'. If s contains no vowels the method returns
	 * false.
	 * <p>
	 * For example:
	 * <pre>{@code
	 * "banana" and "banna" returns true
	 * "Apple" and "ppl" returns false
	 * "Apple" and "pple" returns true
	 * }</pre>
	 * 
	 * @param s longer string
	 * @param t shorter string
	 * @return true if removing one vowel character from s produces the string t
	 */
	public static boolean oneVowelRemoved(String s, String t)
	{
		int i;
		String result;
		
		if(s.length() - 1 == t.length()) {
			for(i = 0; i < s.length(); i++) {
				if (s.charAt(i) == 'a' || s.charAt(i) == 'A' || s.charAt(i) == 'e' || s.charAt(i) == 'E' || s.charAt(i) == 'i' || s.charAt(i) == 'I' || s.charAt(i) == 'o' || s.charAt(i) == 'O' || s.charAt(i) == 'u' || s.charAt(i) == 'U') {
					result = s.substring(0, i) + s.substring(i + 1);
					if(result.equals(t)) {
						return true;
					}
				}
			}
		}
		return false;
	}
	
	/**
	 * Returns a new string in which a UFO pattern in the given string is
	 * shifted one character to the right. The UFO pattern starts with a
	 * {@code '<'}, has one or more {@code '='} and ends with a {@code '>'}. The pattern may wrap
	 * around from the end to the beginning of the string, for example
	 * {@code ">  <="}. Any other characters from the given string remain in place.
	 * If the UFO moves over top of another character, that character is
	 * removed. If there are multiple UFO patterns, only the one that starts
	 * farthest to the left is moved.
	 * <p> 
	 * For example:
	 * <pre>{@code
	 * " <=>  *   . <=> " ->
	 * "  <=> *   . <=> "
	 * 
	 * "   <=>*   .     " ->
	 * "    <=>   .     "
	 * 
	 * ">.   x     .  <=" ->
	 * "=>   x     .   <"
	 * 
	 * " <= <===>   .   " ->
	 * " <=  <===>  .   "
	 * }</pre>
	 * 
	 * @param space given string
	 * @return a new string with a UFO pattern moved one to the right
	 */
	public static String ufo(String space)
	{
		int i, j, k;
		int spacer;
		String result = "";
		for (i = 0; i < space.length(); ++i) {
			spacer = 0;
			if (space.charAt(i) == '<') {
				j = i + 1;
				if (j >= space.length()) {
					j = 0;
				}
				if (space.charAt(j) == '=') {
					while (space.charAt(j) == '=') {
						spacer++;
						j++;
						if (j >= space.length()) {
							j = 0;
						}
					}
					if (space.charAt(j) == '>') { 
						if (i + spacer >= space.length() - 1) { 
							
						}
						if (i + spacer < space.length() - 1) { 
							result = result + space.substring(0, i) + " " + "<";
							for (k = 0; k < spacer; ++k) {
								result = result + "=";
							}
							result = result + ">";
							if (result.length() < space.length()) {
								result = result + space.substring(result.length());
							}
							return result;
						}
					}
				}
			}
		}
		return space;
	}
	
	/**
	 * Prints a pattern of <code>2*n</code> rows containing slashes, dashes and backslashes
	 * as illustrated below.
	 * <p>
	 * When {@code n <= 0 }, prints nothing.
	 * <p> 
	 * <code>n = 1</code>
	 * <pre>
	 * \/
	 * /\
	 * </pre>
	 * <p> 
	 * <code>n = 2</code>
	 * <pre>
	 * \--/
	 * -\/
	 * -/\
	 * /--\
	 * </pre>
	 * <p> 
	 * <code>n = 3</code>
	 * <pre>
	 * \----/
	 * -\--/
	 * --\/
	 * --/\
	 * -/--\
	 * /----\
	 * </pre>
	 * 
	 * @param n number of rows in the output
	 */
	public static void printX(int n)
	{
		int i, j;
		for(i = 0; i < n; i++) {
			for(j = i; j > 0; --j) {
				System.out.print("-");
			}
			System.out.print("\\");
			for(j = 0; j < (n - i - 1) * 2; j++) {
				System.out.print("-");
			}
			System.out.println("/");
		}
		for(i = 0; i < n; i++) {
			for(j = n - 1 - i; j > 0; j--) {
				System.out.print("-");
			}
			System.out.println("/");
			for(j = i*2; j > 0; j--) {
				System.out.print("-");
			}
			System.out.println("\\");
		}
	}
}
