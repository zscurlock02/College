package edu.iastate.cs228.hw4;

import java.io.File;
import java.util.Scanner;

/*
 * This class asks the user for the file name and prints out the decoded message
 * 
 * @author
 * Zachary Scurlock
 */

public class Main {

	public static void main(String args[]) {
		
		int i = 0;
		Scanner scnr = new Scanner(System.in);
		File file;
		
		while(i == 0) {
			System.out.println("Please enter filename to decode");                        // takes user input for file name and loops around if file is not found
			file = new File(scnr.next());
			
			try {
				scnr = new Scanner(file);
				i = 1;
			}
			
			catch(Exception E){
				System.out.println("File not found, please try again");
			}
		}
		
		String symbols = "";
		String oneZero = "";
		int counter = 0;
		int flag = 0;
		
		while(scnr.hasNextLine()) {														//breaks up symbols and ones and zeroes 
			String nextLine = scnr.nextLine();															
			counter++;
			
			for(i = 0; i < nextLine.length(); i++) {
				if(nextLine.charAt(i) == '1' || nextLine.charAt(i) == '0') {
					flag = 1;
				}
				else {
					flag = 0;
					break;
				}
			}
			if(flag == 1) {
				oneZero += nextLine;
			}
			else {
				if(counter == 1) {
					symbols += nextLine;
				}
				else {
					symbols += ("\n" + nextLine);
				}
			}
		}
		
		MsgTree message;																//prints out decrypted message 
		if (symbols.length() > 1) {
			message = new MsgTree(symbols);
		}
		else {
			message = new MsgTree(symbols.charAt(0));
		}
		System.out.println("character code\n----------------------");
		MsgTree.printCodes(message, "");
		System.out.println("MESSAGE:");
		MsgTree temp = new MsgTree(null);
		temp.decode(message, oneZero);
		
		scnr.close();
	}
}
