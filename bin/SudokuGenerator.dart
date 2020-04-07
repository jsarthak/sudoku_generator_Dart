import 'dart:collection';
/**
 * 
 */
import 'dart:math';

import 'Sudoku.dart';

/**
 * 
 * A simple Sudoku Matrix generator. It has utilities to generate a matrix of
 * the following type or a matrix with
 * 
 * <pre>
 *  2 | 3 | 4   5 | 7 | 8   9 | 1 | 6  
 *  5 | 7 | 8   9 | 1 | 6   2 | 3 | 4  
 *  9 | 1 | 6   2 | 3 | 4   5 | 7 | 8  
 * 
 *  3 | 4 | 5   7 | 8 | 9   1 | 6 | 2  
 *  7 | 8 | 9   1 | 6 | 2   3 | 4 | 5  
 *  1 | 6 | 2   3 | 4 | 5   7 | 8 | 9  
 * 
 *  4 | 5 | 7   8 | 9 | 1   6 | 2 | 3  
 *  8 | 9 | 1   6 | 2 | 3   4 | 5 | 7  
 *  6 | 2 | 3   4 | 5 | 7   8 | 9 | 1
 * </pre>
 * 
 * @author sarthak
 * 
 */
class SudokuGenerator {
  static final int MIN_VALID_SUDOKU_NUMBER = 1;
  static final int MAX_VALID_SUDOKU_NUMBER = 9;

  static final int SIZE_OF_EACH_SQUARE = 3;
  static final int VALUE_FOR_EMPTY_CELL = 0;

  static final int NUM_CELLS =
      Sudoku.MAX_VALID_SUDOKU_NUMBER * Sudoku.MAX_VALID_SUDOKU_NUMBER;

  static final Set<int> SUDOKU_NUMBERS = new HashSet<int>();

  /**
	 * Generate a sudoku matrix based on array of number from 1 to 9 ordered
	 * randomly. The algorithm for the generation of the matrix is the
	 * following:
	 * <ul>
	 * <li>
	 * Get the {@link Sudoku} set of the number</li>
	 * <li>
	 * Shuffle the array randomly</li>
	 * <li>
	 * Populate the first 3*3 squares from the previous array</li>
	 * <li>
	 * Execute the band permutation for the other 2 squares of the first row</li>
	 * <li>
	 * Execute band permutation for the other rows;</li>
	 * </ul>
	 * The algorithm has a linear time and a time complexity of O(n) and
	 * iterates over the matrix just once. Given the same original array it
	 * produces always the same sudoku matrix. In general it is capable of
	 * generating 9! different sudoku Matrixs equal to the number of possible
	 * permutation of Sudoku number set.
	 * 
	 * @param numbers
	 * @return
	 */
  static Sudoku generateRandomSudoku() {
    List<int> array = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    _shuffleArray(array);
    Sudoku _sudoku = new Sudoku();
    for (int row = 0; row < Sudoku.SIZE_OF_EACH_SQUARE; row++) {
      populateRow(_sudoku.getMatrix(), row, array);
    }
    return _sudoku;
  }

  static void populateRow(
      List<List<int>> matrix, int row, List<int> shuffledArray) {
    // Iterator over 3 as the number of 3*3 cells for each row
    // int tre = 3;
    for (int j = 0; j < Sudoku.SIZE_OF_EACH_SQUARE; j++) {
      // populate each 3*3 cell
      for (int i = 0; i < Sudoku.MAX_VALID_SUDOKU_NUMBER; i++) {
        int r = (i / Sudoku.SIZE_OF_EACH_SQUARE +
                (Sudoku.SIZE_OF_EACH_SQUARE * row))
            .floor();
        int columnOrder = Sudoku.SIZE_OF_EACH_SQUARE * j;
        int c = i % Sudoku.SIZE_OF_EACH_SQUARE + columnOrder;
        int k = (i + columnOrder) % Sudoku.MAX_VALID_SUDOKU_NUMBER + 1;
        k = shuffledArray[k - 1];
        // Once the first row is populated the other
        // the others can be populated via Band permutations
        if (row > 0) {
          int _rowUpperBandToBeCopied = r - Sudoku.SIZE_OF_EACH_SQUARE * row;
          int _columnUpperBandToBeCopied =
              (c + row) % Sudoku.MAX_VALID_SUDOKU_NUMBER;
          k = matrix[_rowUpperBandToBeCopied][_columnUpperBandToBeCopied];
        }
        matrix[r][c] = k;
      }
    }
  }

  static Sudoku generatePlayableRandomSudoku(SudokuLevel level) {
    Sudoku s = generateRandomSudoku();
    List<int> n = new List(NUM_CELLS);
    for (int i = 0; i < NUM_CELLS; i++) {
      n[i] = i;
    }
    _shuffleArray(n);
    for (int i = 0; i < NUM_CELLS - level.getValorizedCells(); i++) {
      int row_cols = n[i];
      int r = (row_cols / 9).floor();
      int c = row_cols % 9;
      s.getMatrix()[r][c] = 0;
    }
    return s;
  }

  /**
	 * Shuffle and array rundomly
	 * 
	 * @param ar
	 */
  static void _shuffleArray(List<int> array) {
    int index, temp;
    Random random = new Random();
    for (int i = array.length - 1; i > 0; i--) {
      index = random.nextInt(i + 1);
      temp = array[index];
      array[index] = array[i];
      array[i] = temp;
    }
  }
}
