package hw2;

/**
 * Model of a Monopoly-like game. Two players take turns rolling dice to move
 * around a board. The game ends when one of the players has at least
 * MONEY_TO_WIN money or one of the players goes bankrupt (has negative money).
 * 
 * @author Zachary Scurlock
 */
public class CyGame {
	/**
	 * Do nothing square type.
	 */
	public static final int DO_NOTHING = 0;
	/**
	 * Pass go square type.
	 */
	public static final int PASS_GO = 1;
	/**
	 * Cyclone square type.
	 */
	public static final int CYCLONE = 2;
	/**
	 * Pay the other player square type.
	 */
	public static final int PAY_PLAYER = 3;
	/**
	 * Get an extra turn square type.
	 */
	public static final int EXTRA_TURN = 4;
	/**
	 * Jump forward square type.
	 */
	public static final int JUMP_FORWARD = 5;
	/**
	 * Stuck square type.
	 */
	public static final int STUCK = 6;
	/**
	 * Points awarded when landing on or passing over go.
	 */
	public static final int PASS_GO_PRIZE = 200;
	/**
	 * The amount payed to the other player per unit when landing on a
	 * PAY_PLAYER square.
	 */
	public static final int PAYMENT_PER_UNIT = 20;
	/**
	 * The amount of money required to win.
	 */
	public static final int MONEY_TO_WIN = 400;
	/**
	 * The cost of one unit.
	 */
	public static final int UNIT_COST = 50;
	/**
	 * stores Player 1's money
	 */
	private int player1Money;
	/**
	 *  stores Player 1's square
	 */
	private int player1Square;
	/**
	 *  stores number of units owned by Player 1
	 */
	private int player1Units;
	/**
	 *  stores Player 2's money
	 */
	private int player2Money;
	/**
	 *  stores Player 2's square
	 */
	private int player2Square;
	/**
	 *  stores number of units owned by Player 2
	 */
	private int player2Units;
	/**
	 *  Decides if it is Player 1 or 2's turn
	 */
	private int playerTurn;
	/**
	 *  stores the number of squares on the board
	 */
	private int numSquares;
	
	// TODO: EVERTHING ELSE
	// Note that this code will not compile until you have put in stubs for all
	// the required methods.


	// The method below is provided for you and you should not modify it.
	// The compile errors will go away after you have written stubs for the
	// rest of the API methods.
	

	/**
	 * Returns a one-line string representation of the current game state. The
	 * format is:
	 * <p>
	 * <tt>Player 1*: (0, 0, $0) Player 2: (0, 0, $0)</tt>
	 * <p>
	 * The asterisks next to the player's name indicates which players turn it
	 * is. The numbers (0, 0, $0) indicate which square the player is on, how
	 * many units the player has, and how much money the player has
	 * respectively.
	 * 
	 * @return one-line string representation of the game state
	 */
	public String toString() {
		String fmt = "Player 1%s: (%d, %d, $%d) Player 2%s: (%d, %d, $%d)";
		String player1Turn = "";
		String player2Turn = "";
		if (getCurrentPlayer() == 1) {
			player1Turn = "*";
		} else {
			player2Turn = "*";
		}
		return String.format(fmt,
				player1Turn, getPlayer1Square(), getPlayer1Units(), getPlayer1Money(),
				player2Turn, getPlayer2Square(), getPlayer2Units(), getPlayer2Money());
	}
	/**
	 * Constructs a game that has the given number of squares and starts both players on square 0.
	 * @param numSquares
	 * number of squares on board
	 * @param startingMoney
	 * starting money for each player
	 */
	public CyGame(int numSquares, int startingMoney) {
		player2Money = startingMoney;
		player1Money = startingMoney; 
		player1Square = 0;
		player2Square = 0; 
		this.numSquares = numSquares;
		playerTurn = 1;
		player1Units = 1;
		player2Units = 1; 
		
	}

	/**
	 * Called to indicate the current player attempts to buy one unit
	 */
	public void buyUnit() {
		if(!isGameEnded()) {
			if(playerTurn == 1) {
				if(getSquareType(player1Square) == DO_NOTHING) {
					if(player1Money >= UNIT_COST) {
						player1Money -= UNIT_COST;
						player1Units += 1;
						endTurn();
					}
				}
			}
			else if(playerTurn == 2) {
				if(getSquareType(player2Square) == DO_NOTHING) {
					if(player2Money >= UNIT_COST) {
						player2Money -= UNIT_COST;
						player2Units += 1;
						endTurn();
					}
				}
			}
		}
	}
	/**
	 * Called to indicate the current player attempts to sell one unit.
	 */
	public void sellUnit() {
		if(!isGameEnded()) {
			if(playerTurn == 1) {
				if(player1Units >= 1) {
					player1Units -= 1;
					player1Money += UNIT_COST;
					endTurn();
				}
			}
			else if(playerTurn == 2) {
				if(player2Units >= 1) {
					player2Units -= 1;
					player2Money += UNIT_COST;
					endTurn();
				}
			}
		}
	}
	/**
	 *  Called to indicate the current player passes or completes their turn
	 */
	public void endTurn() {
		if(playerTurn == 1) {
			playerTurn = 2;
		}
		else if(playerTurn == 2) {
			playerTurn = 1;
		}
	}
	/**
	 * Get the current player
	 * @return
	 * Returns 1 if it is currently Player 1's turn, otherwise 2
	 */
	public int getCurrentPlayer() {
		return playerTurn;
	}
	/**
	 * Get Player 1's money.
	 * @return
	 * returns Player 1's money
	 */
	public int getPlayer1Money() {
		return player1Money;
	}
	/**
	 * Get Player 1's Square
	 * @return
	 * returns the square number
	 */
	public int getPlayer1Square() {
		return player1Square;
	}
	/**
	 * Get Player 1's units
	 * @return
	 * returns Player 1's units
	 */
	public int getPlayer1Units() {
		return player1Units;
	}
	/**
	 * Get Player 2's money.
	 * @return
	 * returns player 2's money
	 */
	public int getPlayer2Money() {
		return player2Money;
	}
	/**
	 * Get Player 2's Square.
	 * @return
	 * returns the square number
	 */
	public int getPlayer2Square() {
		return player2Square;
	}
	/**
	 * Get Player 2's units.
	 * @return
	 * returns player 2's units
	 */
	public int getPlayer2Units() {
		return player2Units;
	}
	/**
	 * Get the type of square for the given square number. 
	 * @param square
	 * the square number
	 * @return
	 * the type of square the player is on
	 */
	public int getSquareType(int square) {
		if(square == 0) {
			return PASS_GO;
		}
		if(square == numSquares - 1) {
			return CYCLONE;
		}
		if(square % 5 == 0) {
			return PAY_PLAYER;
		}
		if(square % 7 == 0) {
			return EXTRA_TURN;
		}
		if(square % 11 == 0) {
			return EXTRA_TURN;
		}
		if(square % 3 == 0) {
			return STUCK;
		}
		if(square % 2 == 0) {
			return JUMP_FORWARD;
		}
		else {
			return DO_NOTHING;
		}
	}
	/**
	 * Returns true if game is over, false otherwise.
	 * @return
	 * true if game is over, false otherwise
	 */
	public boolean isGameEnded() {
		if(player1Money >= MONEY_TO_WIN || player2Money >= MONEY_TO_WIN) {
			return true;
		}
		else if(player1Money < 0 || player2Money < 0) {
			return true;
		}
		else {
			return false;
		}
	}
	/**
	 * called to indicate the dice has been rolled
	 * @param value
	 * the number rolled by the dice (1 to 6 inclusive)
	 */
	public void roll(int value) {
		if(!isGameEnded()) {
			
			if(playerTurn == 1) {
				if(getSquareType(player1Square) == STUCK) {
					if(value % 2 == 0) {
						if(player1Square + value >= numSquares) {
							player1Money += PASS_GO_PRIZE;
						}
						player1Square = (value + player1Square) % numSquares;
					}
				}
				else if(getSquareType(player1Square) != STUCK) {
					if(player1Square + value >= numSquares) {
						player1Money += PASS_GO_PRIZE;
					}
					player1Square = (value + player1Square) % numSquares;
				}
			
				if(getSquareType(player1Square) == PAY_PLAYER) {
					player1Money -= (PAYMENT_PER_UNIT * player2Units);
					player2Money += (PAYMENT_PER_UNIT * player2Units);
					endTurn();
				}
				else if(getSquareType(player1Square) == EXTRA_TURN) {
				}
				else if(getSquareType(player1Square) == CYCLONE) {
					player1Square = player2Square;
					endTurn();
				}
				else if (getSquareType(player1Square) == JUMP_FORWARD) {
					if(player1Square + 4 >= numSquares) {
						player1Money += PASS_GO_PRIZE;
					}
					player1Square = (4 + player1Square) % numSquares;
					endTurn();
				}
				else {
					endTurn();
				}
			}
			else if(playerTurn == 2) {
				if(getSquareType(player2Square) == STUCK) {
					if(value % 2 == 0) {
						if(player2Square + value >= numSquares) {
							player2Money += PASS_GO_PRIZE;
						}
						player2Square = (value + player2Square) % numSquares;
					}
				}
				else if(getSquareType(player2Square) != STUCK) {
					if(player2Square + value >= numSquares) {
						player2Money += PASS_GO_PRIZE;
					}
					player2Square = (value + player2Square) % numSquares;
				}
			
				if(getSquareType(player2Square) == PAY_PLAYER) {
					player2Money -= (PAYMENT_PER_UNIT * player1Units);
					player1Money += (PAYMENT_PER_UNIT * player1Units);
					endTurn();
				}
				else if(getSquareType(player2Square) == EXTRA_TURN) {
				}
				else if(getSquareType(player2Square) == CYCLONE) {
					player2Square = player1Square;
					endTurn();
				}
				else if (getSquareType(player2Square) == JUMP_FORWARD) {
					if(player2Square + 4 >= numSquares) {
						player2Money += PASS_GO_PRIZE;
					}
					player2Square = (4 + player2Square) % numSquares;
					endTurn();
				}
				else {
					endTurn();
				}
			}
		}
	}
	
	
}