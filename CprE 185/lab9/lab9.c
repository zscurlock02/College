#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define MAXWORDS 100000
#define DEBUG 0 

// Zachary Scurlock
// Lab Section 2

typedef struct {
	char* word;
	int num;
	int first;
	int last;
	} row_t;


void printTable(row_t t[MAXWORDS], int tablelen) {
	int i;
	for (i=0; i<tablelen; i++) {
		printf("%6d: First Occurence = %6d Last Occurence = %6d | %s\n", t[i].num, t[i].first, t[i].last, t[i].word);
		}
	}
//binary search on our table (must be sorted by word
// uses pass by pointer to indicate if the word is in the table
// returns where the word is or should be
int binarySearch(char *word, row_t table[MAXWORDS], int beg, int end, int* found) {
	if (beg > end) {
		// an empty list
		*found = 0;
		return beg;
		}
	int mid = (beg+end)/2;
	int comp = strcmp(table[mid].word, word);
	if (comp == 0) {
		*found = 1;
		return mid;
		}
	// go left?
	if (comp > 0) { // word in middle is greater than word
		return binarySearch(word, table, beg, mid -1, found);
	} else {
		return binarySearch(word, table, mid+1, end, found);
	}
}


int main() {
	row_t* table = malloc(MAXWORDS * sizeof(row_t));
	int numWords =0; // how many words are in table
	char* aWord = malloc(1000 * sizeof(char));
	int success = 0;
	int i;
	int tracker = 1;
	int numread = 0; // total words i read in
	
	while (scanf(" %s", aWord) == 1) {
		if (DEBUG) printf("%s Read\n", aWord);	
		for(i = 0 ; aWord[i]!= '\0' ; i++){
			aWord[i] = tolower(aWord[i]);
		}			
		int found;
		int where = binarySearch(aWord, table,0, numWords-1, &found);
		if (!found) { // word not found
				// shift over
				for (i=numWords-1; i>=where;i--) {
					table[i+1] = table[i];
					}	
				// add word to the table
				table[where].word = malloc((strlen(aWord) +1) * sizeof(char));
				strcpy( table[where].word, 
					aWord);
				// remember to set its num to 1
				table[where].num = 1;
				numWords++; 
				table[where].first= tracker;
				table[where].last= tracker;
		} 
		else {
			table[where].num ++;
			table[where].last = tracker;
		}

		numread++;
		tracker++;
		}
	printTable(table, numWords);
	printf("%d total words read\n", numread);
	}
