export function generateRandomList(numberOfElements) {
  var res = new Array(numberOfElements);
  for(var i = 0; i < res.length; i++) {
    res[i] = Math.random();
  }
  return res;
}

export function generateRandomMatrix(rows, cols) {
  const res = Array.from(Array(rows), () => Array(cols));
  for (var i = 0; i < res.length ; i++) {
    for(var j = 0; j < res.length; j++) {
      res[i][j] = Math.floor(Math.random() * 10);
    }
  }
  return res;
}