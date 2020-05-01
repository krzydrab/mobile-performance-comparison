package com.example.androidalgorithms.algorithms;

import android.util.Log;
import java.util.Arrays;

// Test data
// IN: 4 -2 4 -2 8
//     3 1 4 2 7
//     2 4 2 1 10
//     2 -2 4 2 2
// OUT: -1 2 3 -2
public class GaussElimination {

    public static double[] call(double[][] matrix) {
        int nbOfRows = matrix.length;
        int nbOfCols = matrix[0].length;
        double[] res = new double[nbOfRows];

        for (int i = 0 ; i < nbOfCols - 1 ; ++i) {
            for (int j = i + 1 ; j < nbOfRows; ++j) {
                double f = - matrix[j][i] / matrix[i][i];
                for (int k = i ; k < matrix[i].length; ++k) {
                    matrix[j][k] += f * matrix[i][k];
                }
            }
        }
//        Log.i("Echelon matrix", Arrays.deepToString(matrix));
        for(int i = nbOfRows - 1 ; i >= 0; --i) {
            double s = 0.0;
            // NOTE: -1 because last column is B (AX = B)
            for(int j = i + 1 ; j < nbOfCols - 1 ; ++j) {
                s += matrix[i][j] * res[j];
            }
            res[i] = (matrix[i][nbOfCols - 1] - s) / matrix[i][i];
        }
//        Log.i("Result", Arrays.toString(res));
        return res;
    }
}
