package edu.iastate.cs228.hw4;

import java.util.Stack;
import java.util.ArrayList;

/*
 * Creates tree and decrypts hidden message
 * 
 * @author
 * Zachary Scurlock
 * 
 */

public class MsgTree {
	
	public char payloadChar;
	public MsgTree left;
	public MsgTree right;
	public static int staticCharInx = 0;
	
	/*
	 * Constructor building the tree from a string
	 * 
	 * @param encodingString string pulled from file
	 */
	public MsgTree(String encodingString) {
		if(encodingString == null || encodingString.length() < 2) {
			return;
		}
		Stack<MsgTree> stack = new Stack<>();
		int index = 0;
		this.payloadChar = encodingString.charAt(index++);
		stack.push(this);
		MsgTree current = this;
		int compare = 0;
		
		while(index < encodingString.length()) {
			MsgTree node = new MsgTree(encodingString.charAt(index++));
			if(compare == 0) {
				current.left = node;
				
				if(node.payloadChar == '^') {
					current = stack.push(node);
					compare = 0;
				}
				
				else {
					if(!stack.empty()) {
						current = stack.pop();
					}
					compare = 1;
				}
			}
			else {
				current.right = node;
				
				if(node.payloadChar == '^') {
					current = stack.push(node);
					compare = 0;
				}
				
				else {
					if(!stack.empty()) {
						current = stack.pop();
					}
					compare = 1;
				}
			}
		}
	}
	
	/*
	 * Constructor for a single node with null children
	 * 
	 * @param payloadChar
	 */
	public MsgTree(char payloadChar) {
		this.payloadChar = payloadChar;
		this.left = null;
		this.right = null;
	}
	
	/*
	 * method to print characters and their binary codes
	 * 
	 * @param root
	 * @param code
	 */
	public static void printCodes(MsgTree root, String code) {
		if(root != null) {
			if(root.payloadChar == '^') {
				printCodes(root.right, code + "1");
				printCodes(root.left, code + "0");
			}
			else {
				if(root.payloadChar != '\n') {
					System.out.println(root.payloadChar + "   " + code);
				}
				else {
					System.out.println("\\n  " + code);
				}
				printCodes(root.right, code + "1");
				printCodes(root.left, code + "0");
			}
		}
	}
	
	/*
	 * Prints decoded message
	 * 
	 * @param codes
	 * @param msg
	 */
	public void decode(MsgTree codes, String msg) {
		collectCodes(codes, "");
		String codeFinder = "";
		for(int i = 0; i < msg.length(); i++) {
			codeFinder += msg.charAt(i);
			for(int j = 0; j < listCodes.size(); j++) {
				if(codeFinder.equals(listCodes.get(j))) {
					System.out.print(listChars.get(j));
					codeFinder = "";
					break;
				}
			}
		}
	}
	
	ArrayList<String> listCodes = new ArrayList<String>();
	ArrayList<Character> listChars = new ArrayList<Character>();
	
	/*
	 * Helper method for decode
	 * 
	 * @param root
	 * @param code
	 */
	public void collectCodes(MsgTree root, String code) {
		if(root != null) {
			if(root.payloadChar == '^') {
				collectCodes(root.right, code + "1");
				collectCodes(root.left, code + "0");
			}
			else {
				listCodes.add(code);
				listChars.add(root.payloadChar);
				collectCodes(root.right, code + "1");
				collectCodes(root.left, code + "0");
			}
		}
	}
}
