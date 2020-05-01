package com.example.androidalgorithms;

public class Utils {
    public static double[] generateRandomList(int nbOfElements) {
        double[] array = new double[nbOfElements];
        for(int i = 0; i < array.length; i++) {
            array[i] = Math.random();
        }
        return array;
    }

    public static double[][] generateRandomMatrix(int rows, int cols) {
        double[][] res = new double[rows][cols];
        for (int i = 0; i < res.length ; i++) {
            for(int j = 0; j < res.length; j++) {
                res[i][j] = (int) (Math.random()*10);
            }
        }
        return res;
    }
}
