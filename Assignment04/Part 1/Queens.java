// Java implementation of the homework assignment

import java.util.*;

public class Queens {
    
    // solutions is used to keep track of the arrays of solutions 
    public static List<int[]> solutions = new ArrayList<int[]>();
    // MatrixStack is a stack used to push & pop boards to it used in 
    // the queenSearch function 
    public static MatrixStack chessboards = new MatrixStack();
    
    public static void main(String[] args) {
        // Parse the input from command line and store into var input
        int input = Integer.parseInt(args[0]);
        
        // Runs the main part of the program
        queenSearch(input);
        
        // Display the output 
        for (int i = 0; i < solutions.size(); i++) {
            String solution = Arrays.toString(solutions.get(i));
            System.out.println(solution);
        }
    }
    
    // This method initializes the basecase of queenSearch with the inputs
    public static void queenSearch(int input) {
        int[][] chessboard = new int[input][input];
        int[] currSolution = new int[input];
        Matrix matrixBoard = new Matrix(chessboard);
        chessboards.push(matrixBoard);
        queenSearch(0, currSolution, input);        
    }
    
    public static void queenSearch(int curcol, int[] currSolution, int chessBoardSize) {
        // Iterates through all column values: i here denotes the row # (base 0)        
        for (int i = 0; i < chessBoardSize; i++){
            Matrix matrixChess = chessboards.pop();
            while(chessboards.size() != curcol) {
                matrixChess = chessboards.pop();
            }
            int[][] chessboard = matrixChess.getMatrix();
            if(chessboard[i][curcol] == 0) {
                // Check whether this is the final column in the matrix. If yes, add solution! 
                // If not, recurse to the next column
                // First if checks whether to be sure its not the last col: if it isn't, need to retain board
                if(curcol == (chessboard.length - 1) && (i < chessBoardSize - 1)) {
                    currSolution[curcol] = i;
                    int[] solutionToAdd = new int[currSolution.length];
                    for (int counter = 0; counter < solutionToAdd.length; counter++)
                        solutionToAdd[counter] = currSolution[counter];
                    solutions.add(solutionToAdd);
                    Matrix currentBoard = new Matrix(chessboard);
                    chessboards.push(currentBoard);
                // Does the same as the above if statement, however does not preserve the board if is last row
                } else if (curcol == (chessboard.length - 1)){
                    currSolution[curcol] = i;
                    int[] solutionToAdd = new int[currSolution.length];
                    for (int counter = 0; counter < solutionToAdd.length; counter++)
                        solutionToAdd[counter] = currSolution[counter];
                    solutions.add(solutionToAdd);
                // Below else handles the fact that we're not in the final column. The action is
                // to preserve the current state and push onto the stack. Then, we mark the board and push
                // that marked board onto the stack to be popped and used in the recursion. 
                } else {
                    Matrix currentBoard = new Matrix(chessboard);
                    chessboards.push(currentBoard);
                    currSolution[curcol] = i;
                    int[][] newBoard = markForbidden(chessboard, i, curcol, chessBoardSize);
                    Matrix newMatrix = new Matrix(newBoard);
                    chessboards.push(newMatrix);
                    queenSearch(curcol + 1, currSolution, chessBoardSize);
                }
            } else if (i == chessBoardSize - 1) {
                // intentionally empty: don't need to preserve board!
            } else {
                // not the end of row, need to continue & preserve current board
                Matrix myBoardMatrix = new Matrix(chessboard);
                chessboards.push(myBoardMatrix);
            }
        }
    }
    
    // This method takes the current row/col of the placed queen (predetermined) to be 
    // valid, and marks all further conflicting zones of the board to be tested recursively
    public static int[][] markForbidden(int[][] boardToMark, int currow, int curcol, int size) {
        int[][] returnBoard = new int[size][size];
        // First copy input board into output board returnBoard 
        for (int i = 0; i < returnBoard.length; i++) {
            for (int j = 0; j < returnBoard[i].length; j++) {
                returnBoard[i][j] = boardToMark[i][j];
            }
        }
        
        // Mark the new board  
        for (int i = 0; i < returnBoard.length; i++) {
            for (int j = curcol; j < returnBoard[i].length; j++) {
                if (currow == i)
                    returnBoard[i][j] = 1;
                if (Math.abs(currow - i) == Math.abs(curcol - j))
                    returnBoard[i][j] = 1;
            }
        }
        return returnBoard;
    }
}