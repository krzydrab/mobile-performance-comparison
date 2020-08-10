class Result {
  final int testSize;
  final String description;
  final int time;

  const Result(this.testSize, this.description, this.time);
}

abstract class AlgorithmTester {
  String testDescription(int testSize);
  int test(int testSize);

  List<Result> testAll(int fromTestSize, int toTestSize) {
    List<Result> res = new List<Result>(toTestSize - fromTestSize + 1);
    for(int i = 0; i <= toTestSize - fromTestSize; i++) {
        int size = fromTestSize + i;
        res[i] = new Result(
          size,
          testDescription(size),
          test(size),
        );

        print("Test $size (${i+1} / ${res.length}) completed");
    }
    return res;
  }
}