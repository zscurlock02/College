package lab5;
import java.util.Scanner;

public class NameThing {
	public static void main(String[] args) {
		String fullName = "Edna del Humboldt von der Schooch";
		System.out.println(initials(fullName));
		String vowel = "Racecar";
		System.out.print(vowel(vowel));
		}
	public static String initials(String fullName) {
		String name = "";
		Scanner scnr = new Scanner(fullName);
		while(scnr.hasNext()) {
			String temp = scnr.next();
			name += temp.charAt(0);
		}
		return name;
	}
	public static int vowel(String ch) {
		for(int i = 0; i < "aeiouAEIOU".indexOf(ch); i++) {
			if("aeiouAEIOU".indexOf(ch) >= 0) {
				return "aeiouAEIOU".indexOf(ch);
			}
			else {
				return -1;
			}
		}
	}
	
}
