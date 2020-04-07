import 'dart:io';

import 'Solver.dart';
import 'Sudoku.dart';
import 'SudokuGenerator.dart';

void main(List<String> arguments) {
  Sudoku sudoku = SudokuGenerator.generatePlayableRandomSudoku(
      SudokuLevel(SudokuLevel.EASY));

  for (int i = 0; i < sudoku.getMatrix().length; i++) {
    String t1 = '';
    for (int j = 0; j < sudoku.getMatrix().length; j++) {
      t1 += sudoku.getMatrix()[i][j].toString() + ' ';
    }
    print(t1);
  }
}
