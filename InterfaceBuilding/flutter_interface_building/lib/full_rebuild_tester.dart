import 'dart:io' show Platform;

import 'row_data.dart';
import 'tester.dart';

class FullRebuildTester extends Tester {
  List<int> tests = Platform.isIOS
    ? [1, 250, 500, 750, 1000, 1250, 1500, 1750, 2000]
    : [1, 50, 100, 150, 200, 250, 300, 350, 400];
  int nbOfItems;
  List<RowData> rows;

  List<RowData> generateRows() {
    this.nbOfItems = this.tests[this.testId];
    this.rows = this.generateDefaultRows(this.nbOfItems);
    return this.rows;
  }

  List<RowData> updateRows() {
    final stopwatch = Stopwatch()..start();
    this.rows = this.generateDefaultRows(this.nbOfItems);
    this.timeToModify += stopwatch.elapsedMilliseconds;
    return this.rows;
  }

  void testEnded(double fps) {
    this.results.add(TestResult(this.nbOfItems, fps, this.timeToModify));
  }
}