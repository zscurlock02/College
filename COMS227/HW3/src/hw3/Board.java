package hw3;

import static api.Direction.*;
import static api.Orientation.*;

import java.util.ArrayList;

import api.Cell;
import api.Direction;
import api.Move;

/**
 * Represents a board in the Block Slider game. A board contains a 2D grid of
 * cells and a list of blocks that slide over the cells.
 * 	@author Zachary Scurlock
 */
public class Board {
	/**
	 * Holds the total number of moves made by player
	 */
	private int movesCount;
	
	/**
	 * Cell held by player
	 */
	private Cell grabbedCell;
	
	/**
	 * Block held by player
	 */
	private Block grabbedBlock;
	/**
	 * 2D array of cells, the indexes signify (row, column) with (0, 0) representing
	 * the upper-left corner of the board.
	 */
	private Cell[][] grid;

	/**
	 * A list of blocks that are positioned on the board.
	 */
	private ArrayList<Block> blocks;

	/**
	 * A list of moves that have been made in order to get to the current position
	 * of blocks on the board.
	 */
	private ArrayList<Move> moveHistory;

	/**
	 * Constructs a new board from a given 2D array of cells and list of blocks. The
	 * cells of the grid should be updated to indicate which cells have blocks
	 * placed over them (i.e., setBlock() method of Cell). The move history should
	 * be initialized as empty.
	 * 
	 * @param grid   a 2D array of cells which is expected to be a rectangular shape
	 * @param blocks list of blocks already containing row-column position which
	 *               should be placed on the board
	 */
	public Board(Cell[][] grid, ArrayList<Block> blocks) {
		moveHistory = new ArrayList<Move>();
		movesCount = 0;
		grabbedBlock = null;
		grabbedCell = null;
		this.grid = grid;
		this.blocks = blocks;
		int i, j;
		
		for(i = 0; i < blocks.size(); ++i) {																					//iterates through all blocks
			if(blocks.get(i).getOrientation() == VERTICAL) {																	//checks if the block is vertical
				for(j = blocks.get(i).getFirstRow() + blocks.get(i).getLength() - 1; j >= blocks.get(i).getFirstRow(); --j) {
					this.grid[j][blocks.get(i).getFirstCol()].setBlock(this.blocks.get(i));										//sets the grid where the block is to the block
				}
			}
			if(blocks.get(i).getOrientation() == HORIZONTAL) {																	//checks if the block is horizontal
				for(j = blocks.get(i).getFirstCol(); j < blocks.get(i).getLength() + blocks.get(i).getFirstCol(); ++j) {		
					this.grid[blocks.get(i).getFirstRow()][j].setBlock(this.blocks.get(i));										//sets the grid where the block is to the block
				}
			}
		}
	}

	/**
	 * Constructs a new board from a given 2D array of String descriptions.
	 * <p>
	 * DO NOT MODIFY THIS CONSTRUCTOR
	 * 
	 * @param desc 2D array of descriptions
	 */
	public Board(String[][] desc) {
		this(GridUtil.createGrid(desc), GridUtil.findBlocks(desc));
	}

	/**
	 * Models the user grabbing a block over the given row and column. The purpose
	 * of grabbing a block is for the user to be able to drag the block to a new
	 * position, which is performed by calling moveGrabbedBlock(). This method
	 * records two things: the block that has been grabbed and the cell at which it
	 * was grabbed.
	 * 
	 * @param row row to grab the block from
	 * @param col column to grab the block from
	 */
	public void grabBlockAtCell(int row, int col) {
		if(grid[row][col].hasBlock()) {
			grabbedCell = grid[row][col];
			grabbedBlock = grid[row][col].getBlock();
		}
	}

	/**
	 * Set the currently grabbed block to null.
	 */
	public void releaseBlock() {
		grabbedBlock = null;
	}

	/**
	 * Returns the currently grabbed block.
	 * 
	 * @return the current block
	 */
	public Block getGrabbedBlock() {
		return grabbedBlock;
	}

	/**
	 * Returns the currently grabbed cell.
	 * 
	 * @return the current cell
	 */
	public Cell getGrabbedCell() {
		return grabbedCell;
	}

	/**
	 * Returns true if the cell at the given row and column is available for a block
	 * to be placed over it. Blocks can only be placed over floors and exits. A
	 * block cannot be placed over a cell that is occupied by another block.
	 * 
	 * @param row row location of the cell
	 * @param col column location of the cell
	 * @return true if the cell is available for a block, otherwise false
	 */
	public boolean canPlaceBlock(int row, int col) {
		if((!grid[row][col].hasBlock()) && (grid[row][col].isFloor() || grid[row][col].isExit())) {
			return true;
		}
		return false;
	}

	/**
	 * Returns the number of moves made so far in the game.
	 * 
	 * @return the number of moves
	 */
	public int getMoveCount() {
		return movesCount;
	}

	/**
	 * Returns the number of rows of the board.
	 * 
	 * @return number of rows
	 */
	public int getRowSize() {
		return grid.length;
	}

	/**
	 * Returns the number of columns of the board.
	 * 
	 * @return number of columns
	 */
	public int getColSize() {
		return grid[0].length;
	}

	/**
	 * Returns the cell located at a given row and column.
	 * 
	 * @param row the given row
	 * @param col the given column
	 * @return the cell at the specified location
	 */
	public Cell getCell(int row, int col) {
		return grid[row][col];
	}

	/**
	 * Returns a list of all blocks on the board.
	 * 
	 * @return a list of all blocks
	 */
	public ArrayList<Block> getBlocks() {
		return blocks;
	}

	/**
	 * Returns true if the player has completed the puzzle by positioning a block
	 * over an exit, false otherwise.
	 * 
	 * @return true if the game is over
	 */
	public boolean isGameOver() {
		int i, j;
		for (i = 0; i < getRowSize(); ++i) {								
			for (j = 0; j < getColSize(); ++j) {
				if (grid[i][j].isExit() && grid[i][j].hasBlock()) {			
					return true;											
				}
			}
		}
		return false;					
	}

	/**
	 * Moves the currently grabbed block by one cell in the given direction. A
	 * horizontal block is only allowed to move right and left and a vertical block
	 * is only allowed to move up and down. A block can only move over a cell that
	 * is a floor or exit and is not already occupied by another block. The method
	 * does nothing under any of the following conditions:
	 * <ul>
	 * <li>The game is over.</li>
	 * <li>No block is currently grabbed by the user.</li>
	 * <li>A block is currently grabbed by the user, but the block is not allowed to
	 * move in the given direction.</li>
	 * </ul>
	 * If none of the above conditions are meet, the method does the following:
	 * <ul>
	 * <li>Moves the block object by calling its move method.</li>
	 * <li>Sets the block for the grid cell that the block is being moved into.</li>
	 * <li>For the grid cell that the block is being moved out of, sets the block to
	 * null.</li>
	 * <li>Moves the currently grabbed cell by one cell in the same moved direction.
	 * The purpose of this is to make the currently grabbed cell move with the block
	 * as it is being dragged by the user.</li>
	 * <li>Adds the move to the end of the moveHistory list.</li>
	 * <li>Increment the count of total moves made in the game.</li>
	 * </ul>
	 * 
	 * @param dir the direction to move
	 */
	public void moveGrabbedBlock(Direction dir) {
		int r, c;
		if(!(isGameOver()) && grabbedBlock != null) {																					//checks if game is over and a block is grabbed
			if(grabbedBlock.getOrientation() == HORIZONTAL) {																			//checks if the block is horizontal
				if(dir == RIGHT) {																										//checks if the block is right
					if(canPlaceBlock(grabbedBlock.getFirstRow(), grabbedBlock.getFirstCol() + grabbedBlock.getLength())) {
						grid[grabbedBlock.getFirstRow()][grabbedBlock.getFirstCol() + grabbedBlock.getLength()].setBlock(grabbedBlock); //checks if block can be placed in given direction
						grid[grabbedBlock.getFirstRow()][grabbedBlock.getFirstCol()].clearBlock();
						grabbedBlock.move(RIGHT);																						//moves the block right
						r = grabbedCell.getRow();
						c = grabbedCell.getCol();
						grabbedCell = grid[r][c + 1];																					//moves grabbed cell
						++movesCount;																									//adds to movesCount and moveHistory
						moveHistory.add(new Move(grabbedBlock, dir));
					}
				}
			
			if (dir == LEFT) {																									//checks if block is left
				if (canPlaceBlock(grabbedBlock.getFirstRow(), grabbedBlock.getFirstCol() - 1)) {								
					grid[grabbedBlock.getFirstRow()][grabbedBlock.getFirstCol() - 1].setBlock(grabbedBlock);
					grid[grabbedBlock.getFirstRow()][grabbedBlock.getFirstCol() + grabbedBlock.getLength() - 1].clearBlock();
					grabbedBlock.move(LEFT);																					//moves the block left
					r = grabbedCell.getRow();
					c = grabbedCell.getCol();
					grabbedCell = grid[r][c - 1];																				//moves grabbed cell
					++movesCount;																								//adds to movesCount and moveHistory
					moveHistory.add(new Move(grabbedBlock, dir));
					}
				}
			}
			if (grabbedBlock.getOrientation() == VERTICAL) {																	//checks if block is vertical
				if (dir == DOWN) {																								//checks if block is down
					if (canPlaceBlock(grabbedBlock.getFirstRow() + grabbedBlock.getLength(), grabbedBlock.getFirstCol())) {		
						grid[grabbedBlock.getFirstRow() + grabbedBlock.getLength()][grabbedBlock.getFirstCol()].setBlock(grabbedBlock);
						grid[grabbedBlock.getFirstRow()][grabbedBlock.getFirstCol()].clearBlock();
						grabbedBlock.move(DOWN);																				//moves the block down
						r = grabbedCell.getRow();
						c = grabbedCell.getCol();
						grabbedCell = grid[r + 1][c];																			//moves grabbed cell
						++movesCount;																							//adds to movesCount and moveHistory
						moveHistory.add(new Move(grabbedBlock, dir));
					}
				}
				if (dir == UP) {																								//checks if block is up
					if (canPlaceBlock(grabbedBlock.getFirstRow() - 1, grabbedBlock.getFirstCol())) {							
						grid[grabbedBlock.getFirstRow() - 1][grabbedBlock.getFirstCol()].setBlock(grabbedBlock);
						grid[grabbedBlock.getFirstRow() + grabbedBlock.getLength() - 1][grabbedBlock.getFirstCol()].clearBlock();
						grabbedBlock.move(UP);																					//moves the block up
						r = grabbedCell.getRow();								
						c = grabbedCell.getCol();
						grabbedCell = grid[r - 1][c];																			//moves grabbed cell
						++movesCount;																							//adds to movesCount and moveHistory
						moveHistory.add(new Move(grabbedBlock, dir));
					}
				}
			}
		}
	}

	/**
	 * Resets the state of the game back to the start, which includes the move
	 * count, the move history, and whether the game is over. The method calls the
	 * reset method of each block object. It also updates each grid cells by calling
	 * their setBlock method to either set a block if one is located over the cell
	 * or set null if no block is located over the cell.
	 */
	public void reset() {
		grabbedBlock = null;
		grabbedCell = null;																										
		movesCount = 0;
		moveHistory.clear();
		int i, j;
		for (i = 0; i < grid.length; ++i) {
			for (j = 0; j < grid[0].length; ++j) {																				//clears cells
				grid[i][j].clearBlock();
			}
		}
		for (i = 0; i < blocks.size(); ++i) {																					//reset blocks
			blocks.get(i).reset();
		}
		for (i = 0; i < blocks.size(); ++i) {																					//iterate through blocks 
			if (blocks.get(i).getOrientation() == VERTICAL) {																	//Is block vertical?
				for (j = blocks.get(i).getFirstRow() + blocks.get(i).getLength() - 1; j >= blocks.get(i).getFirstRow(); --j) {
					grid[j][blocks.get(i).getFirstCol()].setBlock(blocks.get(i));												//sets grid to 'i' block
				}
			}
			if (blocks.get(i).getOrientation() == HORIZONTAL) {																	//Is block horizontal?
				for (j = blocks.get(i).getFirstCol(); j < blocks.get(i).getLength() + blocks.get(i).getFirstCol(); ++j) {
					grid[blocks.get(i).getFirstRow()][j].setBlock(blocks.get(i));												//sets grid to 'i' block
				}
			}
		}
	}

	/**
	 * Returns a list of all legal moves that can be made by any block on the
	 * current board. If the game is over there are no legal moves.
	 * 
	 * @return a list of legal moves
	 */
	public ArrayList<Move> getAllPossibleMoves() {
		ArrayList<Move> possibleMoves = new ArrayList<Move>();
		
		if (isGameOver()) {				//if game is over return empty list
			return possibleMoves;
		}
		
		Block block;
		int i;
		for (i = 0; i < blocks.size(); ++i) {															//iterates through all blocks
			block = blocks.get(i);
			if (block.getOrientation() == VERTICAL) {													//checks if block is vertical
				if (canPlaceBlock(block.getFirstRow() + block.getLength(), block.getFirstCol())) {
					possibleMoves.add(new Move(block, DOWN));											//checks if block can be moved down, then adds to list
				}
				if (canPlaceBlock(block.getFirstRow() - 1, block.getFirstCol())) {
					possibleMoves.add(new Move(block, UP));												//checks if block can be moved up, then adds to list
				}
			}
			else if (block.getOrientation() == HORIZONTAL) {											//checks if block is horizontal
				if (canPlaceBlock(block.getFirstRow(), block.getFirstCol() + block.getLength())) {
					possibleMoves.add(new Move(block, RIGHT));											//checks if block can be moved right, then adds to list
				}
				if (canPlaceBlock(block.getFirstRow(), block.getFirstCol() - 1)) {
					possibleMoves.add(new Move(block, LEFT));											//checks if block can be moved left, then adds to list
				}	
			}
		}
		return possibleMoves;			//return all possible moves
	}

	/**
	 * Gets the list of all moves performed to get to the current position on the
	 * board.
	 * 
	 * @return a list of moves performed to get to the current position
	 */
	public ArrayList<Move> getMoveHistory() {
		return moveHistory;
	}

	/**
	 * EXTRA CREDIT 5 POINTS
	 * <p>
	 * This method is only used by the Solver.
	 * <p>
	 * Undo the previous move. The method gets the last move on the moveHistory list
	 * and performs the opposite actions of that move, which are the following:
	 * <ul>
	 * <li>grabs the moved block and calls moveGrabbedBlock passing the opposite
	 * direction</li>
	 * <li>decreases the total move count by two to undo the effect of calling
	 * moveGrabbedBlock twice</li>
	 * <li>if required, sets is game over to false</li>
	 * <li>removes the move from the moveHistory list</li>
	 * </ul>
	 * If the moveHistory list is empty this method does nothing.
	 */
	public void undoMove() {
		// TODO
	}

	@Override
	public String toString() {
		StringBuffer buff = new StringBuffer();
		boolean first = true;
		for (Cell row[] : grid) {
			if (!first) {
				buff.append("\n");
			} else {
				first = false;
			}
			for (Cell cell : row) {
				buff.append(cell.toString());
				buff.append(" ");
			}
		}
		return buff.toString();
	}
}
