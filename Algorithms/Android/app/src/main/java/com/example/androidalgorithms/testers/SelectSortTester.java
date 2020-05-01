package com.example.androidalgorithms.testers;

import com.example.androidalgorithms.Utils;
import com.example.androidalgorithms.algorithms.SelectSort;

public class SelectSortTester extends AlgorithmTester {

    private int[] arraySizes = { 10, 50, 100, 500, 1000, 5000, 10000, 20000, 30000, 40000 };

    @Override
    public String testDescription(int testSize) {
        return String.format("N: %d", arraySizes[testSize]);
    }

    @Override
    public double test(int testSize) {
        double[] arrayToSort = Utils.generateRandomList(arraySizes[testSize]);

        long startTime = System.nanoTime();
        SelectSort.call(arrayToSort);
        return System.nanoTime() - startTime;
    }
}
