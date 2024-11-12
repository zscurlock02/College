// WII-MAZE Skeleton code written by Jason Erbskorn 2007
// Edited for ncurses 2008 Tom Daniels
// Updated for Esplora 2013 TeamRursch185
// Updated for DualShock 4 2016 Rursch


// Headers
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ncurses/ncurses.h>
#include <unistd.h>

// Mathematical constants
#define PI 3.14159

// Screen geometry
// Use ROWS and COLS for the screen height and width (set by system)
// MAXIMUMS
#define NUMCOLS 100
#define NUMROWS 72

// Character definitions taken from the ASCII table
#define AVATAR 'A'
#define WALL '*'
#define EMPTY_SPACE ' '


// 2D character array which the maze is mapped into
char MAZE[NUMROWS][NUMCOLS];


// POST: Generates a random maze structure into MAZE[][]
//You will want to use the rand() function and maybe use the output %100.  
//You will have to use the argument to the command line to determine how 
//difficult the maze is (how many maze characters are on the screen).
void generate_maze(int difficulty);

// PRE: MAZE[][] has been initialized by generate_maze()
// POST: Draws the maze to the screen 
void draw_maze(void);

// PRE: 0 < x < COLS, 0 < y < ROWS, 0 < use < 255
// POST: Draws character use to the screen and position x,y
void draw_character(int x, int y, char use);

// PRE: -1.0 < x_mag < 1.0
// POST: Returns tilt magnitude scaled to -1.0 -> 1.0
// You may want to reuse the roll function written in previous labs.  
float calc_roll(float x_mag);

// Main - Run with './ds4rd.exe -t -g -b' piped into STDIN
int main(int argc, char* argv[])
{
	if (argc <2) { printf("You forgot the difficulty\n"); return 1;}
	int difficulty = atoi(argv[1]); // get difficulty from first command line arg
	// setup screen    
	initscr();
	refresh();

	// Generate and draw the maze, with initial avatar

	// Read gyroscope data to get ready for using moving averages.    

	// Event loop
	double gx, gy, gz;
	int B_T, B_C, B_X, B_S;
	int t;
	int posX = 49;
	int posY = 0;
	int loop = 0;
	
	generate_maze(difficulty);
	draw_maze();
	
	do
	{
	scanf("%d, %lf, %lf, %lf, %d, %d, %d, %d", &t, &gx, &gy, &gz, &B_T, &B_C, &B_X, &B_S);
		// Read data, update average
	loop++;
	if(loop == 35){
		draw_character(posX, posY, EMPTY_SPACE);
		++posY;
			if ((MAZE[posY][posX] == WALL) && (MAZE[posY-1][posX + 1] == WALL) && (MAZE[posY - 1][posX - 1] == WALL)) {
					endwin();
					printf("You were completely surrounded by walls.");
					return 0;
				}
				if ((MAZE[posY][posX] == WALL) && (MAZE[posY-1][posX + 1] != WALL) && (MAZE[posY - 1][posX - 1] != WALL)) {
					endwin();
					printf("Game Over! You could have moved left or right.");
					return 0;
				}
				if (MAZE[posY][posX] == WALL) {
					endwin();
					printf("Game Over!");
					return 0;
				}
		draw_character(posX, posY, AVATAR);
		loop = 0;
}
	
	if(loop == 10){
		if(gx < -0.4){
			draw_character(posX, posY, EMPTY_SPACE);
				posX++;
			if(posX == 99){
				posX--;
			}
			if(MAZE[posY][posX] == WALL){
				posX--;
			}
			draw_character(posX, posY, AVATAR);
			loop = 0;
		}
	
		if(gx > 0.4){
			draw_character(posX, posY, EMPTY_SPACE);
				posX--;
			if(posX == 0){
				posX++;
			}
			if(MAZE[posY][posX] == WALL){
				posX++;
			}
			draw_character(posX, posY, AVATAR);
		}
	}
	
	} while(posY != 72); // Change this to end game at right time 

	// Print the win message
	endwin();
	
	printf("YOU WIN!\n");
	return 0;
}

// PRE: 0 < x < COLS, 0 < y < ROWS, 0 < use < 255
// POST: Draws character use to the screen and position x,y
//THIS CODE FUNCTIONS FOR PLACING THE AVATAR AS PROVIDED.
//
//    >>>>DO NOT CHANGE THIS FUNCTION.<<<<
void draw_character(int x, int y, char use){
	mvaddch(y,x,use);    
	refresh();
}
void generate_maze(int difficulty){
	for(int i = 0; i < NUMROWS; i++){
		for(int j = 0; j < NUMCOLS; j++){
			if(rand() % 100 < difficulty){
				MAZE[i][j] = WALL;
			}
			else {
				MAZE[i][j] = EMPTY_SPACE;
			}
		}
	}
}
void draw_maze(void){
	for(int i = 0; i < NUMROWS; i++){
		for(int j = 0; j < NUMCOLS; j++){
			draw_character(j, i, MAZE[i][j]);
		}
	}
}
float calc_roll(float x_mag){
	return asin(x_mag);
}