//
//  GaussElimination.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 17/05/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

func gaussElimination(matrix: inout [[Double]]) -> [Double] {
    let nbOfRows: Int = matrix.count;
    let nbOfCols: Int = matrix[0].count;
    var res = Array<Double>(repeating: 0.0, count: nbOfRows)

    var i = 0, j = 0, k = 0;
    while(i < nbOfCols - 1) {
        j = i + 1;
        while(j < nbOfRows) {
            let f: Double = -matrix[j][i] / matrix[i][i];
            k = i;
            while(k < matrix[i].count) {
                matrix[j][k] += f * matrix[i][k];
                k += 1;
            }
            j += 1;
        }
        i += 1;
    }

    i = nbOfRows - 1;
    while(i >= 0) {
        var s: Double = 0.0;
        // NOTE: -1 because last column is B (AX = B)
        j = i + 1;
        while(j < nbOfCols - 1) {
            s += matrix[i][j] * res[j];
            j += 1;
        }
        res[i] = (matrix[i][nbOfCols - 1] - s) / matrix[i][i];
        i -= 1;
    }

    return res;
}
