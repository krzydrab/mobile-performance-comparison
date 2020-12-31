import 'package:flutter_algorithms/utils.dart';
import 'package:flutter_algorithms/testers/algorithm_tester.dart';
import 'package:flutter_algorithms/algorithms/gauss_elimination.dart';

class GaussEliminationTester extends AlgorithmTester {
  List<int> arraySizes = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600];

  @override
  String testDescription(int testSize) {
      int size = arraySizes[testSize];
      return "Matrix $size x $size";      
  }

  @override
  int test(int testSize) {
    int s = arraySizes[testSize];

    // Ax = B
    // R = [A|B]
    List<double> x = Utils.generateRandomList(s);
    List<List<double>> R = Utils.generateRandomMatrix(s, s + 1);
    for(int i = 0 ; i < s; i++) {
        double b = 0;
        for(int j = 0; j < s; j++) {
            b += R[i][j] * x[j];
        }
        R[i][s] = b;
    }

    final stopwatch = Stopwatch()..start();
    GaussElimination.call(R);
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }
}