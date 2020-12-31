package com.example.androidalgorithms.testers;

import com.example.androidalgorithms.algorithms.AckermannFunction;

public class AckermannFunctionTester extends AlgorithmTester {
    @Override
    public String testDescription(int testSize) {
        return String.format("m = %d, n = %d", 3, 1 + testSize);
    }

    @Override
    public double test(int testSize) {
        int m = 3;
        int n = 1 + testSize;

        long startTime = System.nanoTime();
        AckermannFunction.call(m, n);
        return System.nanoTime() - startTime;
    }
}