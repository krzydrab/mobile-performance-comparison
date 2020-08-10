import 'package:flutter_algorithms/testers/algorithm_tester.dart';
import 'package:flutter_algorithms/algorithms/ackermann_function.dart';

class AckermannFunctionTester extends AlgorithmTester {
  @override
  String testDescription(int testSize) {
      return "m = 3, n = ${3 + testSize}";
  }

  @override
  int test(int testSize) {
      int m = 3;
      int n = 3 + testSize;

      final stopwatch = Stopwatch()..start();
      AckermannFunction.call(m, n);
      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
  }
}