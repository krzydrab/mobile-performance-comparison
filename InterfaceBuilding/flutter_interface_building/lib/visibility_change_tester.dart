import 'dart:io' show Platform;

import 'row_data.dart';
import 'tester.dart';

class VisibilityChangeTester extends Tester {
  List<int> tests = Platform.isIOS
    ? [5, 25, 50, 75, 100, 125, 150, 175, 200]
    : [1, 10, 20, 30, 40, 50, 60, 70, 80];
  int nbOfItems = Platform.isIOS ? 500 : 150;
  int nbOfChanges = 0;
  List<RowData> rows;
  List<int> visibleRowsIds;
  List<int> invisibleRowsIds;

  List<RowData> generateRows() {
    this.nbOfChanges = this.tests[this.testId];
    int totalNbOfItems = this.nbOfChanges + this.nbOfItems;
    this.rows = this.generateDefaultRows(totalNbOfItems);
    this.visibleRowsIds = new List<int>.generate(totalNbOfItems, (i) => i);
    this.visibleRowsIds.shuffle();
    this.invisibleRowsIds = this.visibleRowsIds.sublist(0, this.nbOfChanges);
    this.invisibleRowsIds.forEach((id) => this.rows[id].visibility = false);
    this.visibleRowsIds.removeRange(0, this.nbOfChanges);
    return this.rows.where((e) => e.visibility).toList();
  }

  List<RowData> updateRows() {
    final stopwatch = Stopwatch()..start();
    this.invisibleRowsIds.forEach((id) => this.rows[id].visibility = true);
    this.visibleRowsIds = this.invisibleRowsIds + this.visibleRowsIds;
    this.invisibleRowsIds = this.visibleRowsIds.sublist(this.visibleRowsIds.length - this.nbOfChanges);
    this.visibleRowsIds.removeRange(
      this.visibleRowsIds.length - this.nbOfChanges,
      this.visibleRowsIds.length
    );
    this.invisibleRowsIds.forEach((id) => this.rows[id].visibility = false);
    this.timeToModify += stopwatch.elapsedMilliseconds;
    return this.rows.where((e) => e.visibility).toList();
  }

  void testEnded(double fps) {
    this.results.add(TestResult(this.nbOfChanges, fps, this.timeToModify));
  }
}
