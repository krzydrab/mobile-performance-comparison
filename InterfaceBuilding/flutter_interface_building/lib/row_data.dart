import 'dart:math';

class RowData {
  int id;
  double value;
  bool visibility = true;

  RowData() {
    var rng = new Random();
    this.id = rng.nextInt(10000);
    this.value = rng.nextDouble();
  }
}