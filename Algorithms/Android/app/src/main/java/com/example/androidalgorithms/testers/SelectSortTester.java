package com.example.androidalgorithms.testers;

import com.example.androidalgorithms.Utils;
import com.example.androidalgorithms.algorithms.SelectSort;

public class SelectSortTester extends AlgorithmTester {

    private int[] arraySizes = { 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000 };

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
