package com.example.androidalgorithms.testers;

import android.util.Log;

public abstract class AlgorithmTester {
    public class Result {
        public int testSize;
        public String description;
        public double time;
    }

    public abstract String testDescription(int testSize);
    public abstract double test(int testSize);

    public Result[] testAll(int fromTestSize, int toTestSize) {
        Result[] res = new Result[toTestSize - fromTestSize + 1];
        for(int i = 0; i <= toTestSize - fromTestSize; i++) {
            int size = fromTestSize + i;
            res[i] = new Result();
            res[i].time = test(size);
            res[i].description = testDescription(size);
            res[i].testSize = size;

            Log.i("custom", String.format("Test %d (%d / %d) completed", size, i+1, res.length));
        }
        return res;
    }
}
