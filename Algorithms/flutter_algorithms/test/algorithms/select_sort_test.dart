import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_algorithms/algorithms/select_sort.dart';

void main() {
  test('SelectSort should properly sort an array', () {
    final List<double> input = [0.2, 11, 3.14, -1, 1, 0.21, 10.999];
    final List<double> expected = [-1, 0.2, 0.21, 1, 3.14, 10.999, 11];
    final List<double> actual = SelectSort.call(input);

    expect(expected, actual);
  });
}