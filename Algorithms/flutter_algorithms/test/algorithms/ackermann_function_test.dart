import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_algorithms/algorithms/ackermann_function.dart';

void main() {
  test('AckermannFunction returns valid value for small input', () {
    expect(AckermannFunction.call(2, 3), 9);
  });

  test('AckermannFunction returns valid value for big input', () {
    expect(AckermannFunction.call(3, 5), 253);
  });
}