import 'dart:collection';

class SudokuLevel {
  static final int BEGINNER = 50,
      EASY = 40,
      MEDIUM = (33),
      HARD = 26,
      EXTREME = (17);

  int valorizedCells;

  SudokuLevel(int valorizedCells) {
    this.valorizedCells = valorizedCells;
  }

  int getValorizedCells() {
    return valorizedCells;
  }
}

class Sudoku {
  static final String SEPARATOR = ',';

  static final int MIN_VALID_SUDOKU_NUMBER = 1;
  static final int MAX_VALID_SUDOKU_NUMBER = 9;

  static final int SIZE_OF_EACH_SQUARE = 3;
  static final int VALUE_FOR_EMPTY_CELL = 0;

  static final Set<int> SUDOKU_NUMBERS = new HashSet<int>();

  Sudoku() {
    for (int i = MIN_VALID_SUDOKU_NUMBER; i <= MAX_VALID_SUDOKU_NUMBER; i++) {
      SUDOKU_NUMBERS.add(i);
    }
  }
  List<List<int>> _matrix = List.generate(9, (i) => List.generate(9, (j) => 0));
  List<List<bool>> numbersSetPerRow = [];
  List<List<bool>> numbersSetPerColumns = [];

  static bool isValidSudokuNumber(int number) {
    return (number >= MIN_VALID_SUDOKU_NUMBER - 1 &&
        number <= MAX_VALID_SUDOKU_NUMBER);
  }

  bool addNumberToSudokuMatrix(int row, int col, int n) {
    if (n > 0 &&
        (numbersSetPerRow[row][n - 1] || numbersSetPerColumns[col][n - 1])) {
      return false;
    } else {
      _matrix[row][col] = n;
      if (n > 0) {
        numbersSetPerRow[row][n - 1] = true;
        numbersSetPerColumns[col][n - 1] = true;
      }
      return true;
    }
  }

  List<List<int>> getMatrix() {
    return _matrix;
  }

  void setMatrix(List<List<int>> matrix) {
    _matrix = matrix;
  }

  bool isValid() {
    // reinitialize the check matrix in case they has been already used to
    // stream the number in the sudoku
    numbersSetPerRow = [];
    numbersSetPerColumns = [];
    for (int row = 0; row < MAX_VALID_SUDOKU_NUMBER; row++) {
      for (int col = 0; col < MAX_VALID_SUDOKU_NUMBER; col++) {
        int n = _matrix[row][col];
        if (n > VALUE_FOR_EMPTY_CELL &&
            (numbersSetPerRow[row][n - 1] ||
                numbersSetPerColumns[col][n - 1])) {
          return false;
        } else {
          if (n > VALUE_FOR_EMPTY_CELL) {
            numbersSetPerRow[row][n - 1] = true;
            numbersSetPerColumns[col][n - 1] = true;
          }
        }
      }
    }

    return true;
  }
}
