package com.example.androidalgorithms.testers;

import com.example.androidalgorithms.Utils;
import com.example.androidalgorithms.algorithms.GaussElimination;

public class GaussEliminationTester extends AlgorithmTester {
    private int[] arraySizes = { 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600 };

    @Override
    public String testDescription(int testSize) {
        int size = arraySizes[testSize];
        return String.format("Matrix %d x %d", size, size);
    }

    @Override
    public double test(int testSize) {
        int s = arraySizes[testSize];
        // Ax = B
        // R = [A|B]
        double[] x = Utils.generateRandomList(s);
        double[][] R = Utils.generateRandomMatrix(s, s + 1);
        for(int i = 0 ; i < s; i++) {
            double b = 0;
            for(int j = 0; j < s; j++) {
                b += R[i][j] * x[j];
            }
            R[i][s] = b;
        }

        long startTime = System.nanoTime();
        GaussElimination.call(R);
        return System.nanoTime() - startTime;
    }
}
