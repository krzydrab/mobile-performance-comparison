import 'dart:io' show Platform;
import 'dart:math';

import 'row_data.dart';
import 'tester.dart';

class SwapTester extends Tester {
  List<int> tests = Platform.isIOS
    ? [5, 25, 50, 75, 100, 125, 150, 175, 200]
    : [1, 10, 20, 30, 40, 50, 60, 70, 80];
  int nbOfItems = Platform.isIOS ? 800 : 150;
  int nbOfChanges = 0;
  List<RowData> rows;

  List<RowData> generateRows() {
    this.nbOfChanges = this.tests[this.testId];
    this.rows = this.generateDefaultRows(this.nbOfItems);
    return this.rows;
  }

  List<RowData> updateRows() {
    final stopwatch = Stopwatch()..start();
    var rng = new Random();
    RowData temp;
    for(var i = 0 ; i < this.nbOfChanges ; i++) {
      int a = rng.nextInt(this.nbOfItems);
      int b = rng.nextInt(this.nbOfItems);
      temp = this.rows[a];
      this.rows[a] = this.rows[b];
      this.rows[b] = temp;
    }
    this.timeToModify += stopwatch.elapsedMilliseconds;
    return this.rows;
  }

  void testEnded(double fps) {
    this.results.add(TestResult(this.nbOfChanges, fps, this.timeToModify));
  }
}