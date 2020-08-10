class AckermannFunction {
  static int call(int m, int n) {
    if(m == 0) return n + 1;
    if(m > 0 && n == 0) return call(m - 1, 1);
    return call(m - 1, call(m, n - 1));
  }
}