import 'package:flutter_algorithms/utils.dart';
import 'package:flutter_algorithms/testers/algorithm_tester.dart';
import 'package:flutter_algorithms/algorithms/select_sort.dart';

class SelectSortTester extends AlgorithmTester {
  final List<int> arraySizes = [100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 20000];

  @override
  String testDescription(int testSize) {
    return "N: ${arraySizes[testSize]}";
  }

  @override
  int test(int testSize) {
    List<double> arrayToTest = Utils.generateRandomList(arraySizes[testSize]);

    final stopwatch = Stopwatch()..start();
    SelectSort.call(arrayToTest);
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }
}