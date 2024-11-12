package lab7;

import java.io.File;

public class FileCounter {
	public static void main(String[] args) {
		File rootDirectory = new File(".");
		System.out.println(countFiles(rootDirectory));
	}
	public static int countFiles(File f) {
		int count = 0;
		int i;
		File[] files = f.listFiles();
		
		for(i = 0; i < files.length; ++i) {
			if(files[i].isFile()) {
				count++;
			}
			else {
				count += countFiles(files[i]);
			}
		}
		return count;
	}
}
