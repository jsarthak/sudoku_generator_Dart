import 'Sudoku.dart';

class Solver {
  static bool isSafe(List<List<int>> board, int row, int col, int num) {
    for (int d = 0; d < board.length; d++) {
      if (board[row][d] == num) {
        return false;
      }
    }

    for (int r = 0; r < board.length; r++) {
      if (board[r][col] == num) {
        return false;
      }
    }

    int sqrt = 9;
    int boxRowStart = row - row % sqrt;
    int boxColStart = row - col % sqrt;

    for (int r = boxRowStart; r < boxRowStart + sqrt; r++) {
      for (int d = boxColStart; d < boxColStart + sqrt; d++) {
        if (board[r][d] == num) {
          return false;
        }
      }
    }

    return true;
  }

  static bool solveSudoku(List<List<int>> board, int n) {
    int row = -1;
    int col = -1;
    bool isEmpty = true;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (board[i][j] == 0) {
          row = i;
          col = j;

          // we still have some remaining
          // missing values in Sudoku
          isEmpty = false;
          break;
        }
      }
      if (!isEmpty) {
        break;
      }
    }

    // no empty space left
    if (isEmpty) {
      return true;
    }

    // else for each-row backtrack
    for (int num = 1; num <= n; num++) {
      if (isSafe(board, row, col, num)) {
        board[row][col] = num;
        if (solveSudoku(board, n)) {
          // print(board, n);
          return true;
        } else {
          board[row][col] = 0; // replace it
        }
      }
    }
    return false;
  }
}
