
class GaussElimination {
  static List<double> call(List<List<double>> matrix) {
    int nbOfRows = matrix.length;
    int nbOfCols = matrix[0].length;
    List<double> res = List<double>(nbOfRows);

    for (int i = 0 ; i < nbOfCols - 1 ; ++i) {
      for (int j = i + 1 ; j < nbOfRows; ++j) {
        double f = - matrix[j][i] / matrix[i][i];
        for (int k = i ; k < matrix[i].length; ++k) {
          matrix[j][k] += f * matrix[i][k];
        }
      }
    }
    // print(matrix);
    for(int i = nbOfRows - 1 ; i >= 0; --i) {
      double s = 0.0;
      // NOTE: -1 because last column is B (AX = B)
      for(int j = i + 1 ; j < nbOfCols - 1 ; ++j) {
        s += matrix[i][j] * res[j];
      }
      res[i] = (matrix[i][nbOfCols - 1] - s) / matrix[i][i];
    }
    // print(res);
    return res;
  }
}