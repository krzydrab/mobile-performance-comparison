import 'dart:math';

class Utils {
  static List<double> generateRandomList(int nbOfElements) {
    var random = new Random();
    List<double> res = List(nbOfElements);
    for (var i = 0; i < nbOfElements; i++) {
      res[i] = random.nextDouble();
    }
    return res;
  }

  static bool compareListsWithDelta(List<double> l1, List<double> l2, [double delta = 0.0000001]) {
    if (l1.length != l2.length) {
      return false;
    }
    for (int i = 0 ; i < l1.length; i++) {
      if ((l1[i] - l2[i]).abs() > delta) {
        return false;
      }
    }
    return true;
  }

  static List<List<double>> generateRandomMatrix(int rows, int cols) {
    var random = new Random();
    List<List<double>> res = List.generate(rows, (_) => List<double>(cols));
    for (int i = 0; i < res.length ; i++) {
      for(int j = 0; j < res.length; j++) {
        res[i][j] = random.nextInt(10).toDouble();
      }
    }
    return res;
  }
}