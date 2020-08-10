
class SelectSort {
  static List<double> call(List<double> list) {
    for(int i = 0; i < list.length - 1; i++) {
      int minElPos = i;
      for(int j = minElPos + 1; j < list.length; j++) {
        if(list[j] < list[minElPos]) {
          minElPos = j;
        }
      }
      // swap
      double temp = list[i];
      list[i] = list[minElPos];
      list[minElPos] = temp;
    }
    return list;
  }
}