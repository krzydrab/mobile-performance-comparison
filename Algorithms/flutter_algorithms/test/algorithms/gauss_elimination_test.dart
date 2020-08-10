import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_algorithms/utils.dart';
import 'package:flutter_algorithms/algorithms/gauss_elimination.dart';

void main() {
  test('Gauss elimination should properly solve system of equations', () {
    final List<List<double>> testMatrix = [
        [ 4, -2, 4, -2, 8 ],
        [ 3, 1, 4, 2, 7 ],
        [ 2, 4, 2, 1, 10 ],
        [ 2, -2, 4, 2, 2],
    ];
    List<double> expected = [ -1, 2, 3, -2 ];
    List<double> actual = GaussElimination.call(testMatrix);

    expect(Utils.compareListsWithDelta(expected, actual), true);
  });
}