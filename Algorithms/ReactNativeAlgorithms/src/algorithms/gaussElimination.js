
export default function gaussElimination(matrix) {
  const nbOfRows = matrix.length;
  const nbOfCols = matrix[0].length;
  const res = Array(nbOfRows);

  for (var i = 0 ; i < nbOfCols - 1 ; ++i) {
    for (var j = i + 1 ; j < nbOfRows; ++j) {
      var f = - matrix[j][i] / matrix[i][i];
      for (var k = i ; k < matrix[i].length; ++k) {
        matrix[j][k] += f * matrix[i][k];
      }
    }
  }
  // console.log(matrix);
  for(var i = nbOfRows - 1 ; i >= 0; --i) {
    var s = 0.0;
    // NOTE: -1 because last column is B (AX = B)
    for(var j = i + 1 ; j < nbOfCols - 1 ; ++j) {
      s += matrix[i][j] * res[j];
    }
    res[i] = (matrix[i][nbOfCols - 1] - s) / matrix[i][i];
  }
  // print(res);
  return res;
}