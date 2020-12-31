//
//  GaussEliminationTester.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 29/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class GaussEliminationTester:  AlgorithmTester {
    let arraySizes: [Int] = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600]

    override func testDescription(testSize: Int) -> String {
        let size: Int = arraySizes[testSize]
        return "Matrix \(size) x \(size)"
    }

    override func test(testSize: Int) -> Double {
        let s: Int = arraySizes[testSize];

        // Ax = B
        // R = [A|B]
        let x: [Double] = generateRandomList(size: s);
        var R: [[Double]] = generateRandomMatrix(rows: s, cols: s + 1);
        for i in 0..<s {
            var b: Double = 0
            for j in 0..<s {
                b += R[i][j] * x[j]
            }
            R[i][s] = b
        }

        let startingPoint = Date()
        gaussElimination(matrix: &R);
        return startingPoint.timeIntervalSinceNow * -1;
    }
}
