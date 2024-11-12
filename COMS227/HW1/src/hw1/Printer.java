package hw1;
/**
 * Simulated Printer
 * @author Zachary Scurlock
 */
public class Printer {
	/*
	 * Holds the amount of pages in the document
	 */
	private int sheetsInDoc;
	/*
	 * Holds the maximum count of pages that can be in the tray
	 */
	private int trayMax;
	/*
	 * Holds the value of the next page
	 */
	private int nextPage;
	/*
	 * Holds the total count of pages
	 */
	private int totalPages;
	/*
	 * Holds number of available sheets
	 */
	private int sheetsAvailable; 
	/*
	 * Holds number of sheets currently in the tray
	 */
	private int sheetsInTray;
	/**
	 * Constructs printer with given tray capacity. (Printers starts off empty)
	 * @param trayCapacity
	 * The amount of paper the tray can hold
	 */
	public Printer(int trayCapacity) {
		trayMax = trayCapacity;
		totalPages = 0;
	}
	/**
	 * Starts new print job to make copies of a document that is a specified page length 
	 * @param documentPages
	 * Amount of pages in the document
	 */
	public void startPrintJob(int documentPages) {
		sheetsInDoc = documentPages;
		nextPage = 0;
	}
	/**
	 * Returns number of sheets available for printing
	 * @return
	 * amount of available sheets in the printer
	 */
	public int getSheetsAvailable() {
		return sheetsAvailable;
	}
	/**
	 * Returns the next page number of the document that will be printed
	 * @return
	 * Returns the next page
	 */
	public int getNextPage() {
		return nextPage;
	}
	/**
	 * Returns the count of all pages printed by the printer since its construction.
	 * @return
	 * Returns the total page count
	 */
	public int getTotalPages() {
		return totalPages;
	}
	/**
	 * Simulates the printer printing a page
	 */
	public void printPage() {
		nextPage += Math.min(sheetsAvailable, 1);
		nextPage = nextPage % sheetsInDoc; 
		totalPages += Math.min(sheetsAvailable, 1);
		sheetsAvailable -= Math.min(sheetsAvailable, 1);
	}
	/*
	 * Removes the paper tray from the printer; that is, makes the sheets available to the printer zero.  
	 */
	public void removeTray() {
		sheetsInTray = sheetsAvailable; 
		sheetsAvailable = 0;
	}
	/*
	 * Replaces the tray into the printer; making the sheets in the printer equal to the sheets in the tray
	 */
	public void replaceTray() {
		sheetsAvailable = sheetsInTray;
	}
	/**
	 * Simulates removing the tray, adding the given number of sheets (up to the maximum capacity of 
	   the tray), and replacing the tray in the printer. 
	 * @param sheets
	 * Amount of sheets being added to the tray
	 */
	public void addPaper(int sheets) {
		sheetsInTray += sheets;
		sheetsInTray = Math.min(trayMax, sheetsInTray);
		sheetsAvailable = sheetsInTray;
	}
	/**
	 * Simulates removing the tray, removing the given number of sheets (but not allowing the sheets to 
	   go below zero), and replacing the tray in the printer. 
	 * @param sheets
	 * Amount of sheets being removed from the tray
	 */
	public void removePaper(int sheets) {
		sheetsInTray -= sheets;
		sheetsInTray = Math.max(0, sheetsInTray);
		sheetsAvailable = sheetsInTray;
	}
}

