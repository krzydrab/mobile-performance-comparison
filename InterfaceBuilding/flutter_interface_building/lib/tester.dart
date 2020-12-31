import 'package:flutter_interface_building/row_data.dart';

class TestResult {
  int n;
  double fps;
  double timeToModify;

  TestResult([this.n, this.fps, this.timeToModify]);
}

abstract class Tester {
  List<TestResult> results = [];
  List<int> tests = [];
  double timeToModify;
  int testId = -1;

  List<RowData> generateRows();
  List<RowData> updateRows();
  void testEnded(double fps);

  List<RowData> generateDefaultRows(nbOfRows) {
    return new List(nbOfRows).map((e) => RowData()).toList();
  }

  List<RowData> nextTest() {
    this.testId += 1;
    this.timeToModify = 0.0;
    return this.generateRows();
  }

  bool isCompleted() {
    return this.testId >= this.tests.length - 1;
  }
}