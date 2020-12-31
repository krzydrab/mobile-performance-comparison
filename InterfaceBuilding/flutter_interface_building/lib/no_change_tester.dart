import 'dart:io' show Platform;
import 'dart:math';

import 'row_data.dart';
import 'tester.dart';

class NoChangeTester extends Tester {
  List<int> tests = Platform.isIOS
    ? [1, 250, 500, 750, 1000, 1250, 1500, 1750, 2000]
    : [1, 50, 100, 150, 200, 250, 300, 350, 400];
  int nbOfItems = 0;
  List<RowData> rows;

  List<RowData> generateRows() {
    this.nbOfItems = this.tests[this.testId];
    this.rows = this.generateDefaultRows(this.nbOfItems);
    return this.rows;
  }

  List<RowData> updateRows() {
    // final stopwatch = Stopwatch()..start();
    // var rng = new Random();
    // RowData temp;
    // for(var i = 0 ; i < 1 ; i++) {
    //   int a = rng.nextInt(this.nbOfItems);
    //   int b = rng.nextInt(this.nbOfItems);
    //   temp = this.rows[a];
    //   this.rows[a] = this.rows[b];
    //   this.rows[b] = temp;
    // }
    // this.timeToModify += stopwatch.elapsedMilliseconds;
    return this.rows;
  }

  void testEnded(double fps) {
    this.results.add(TestResult(this.nbOfItems, fps, this.timeToModify));
  }
}