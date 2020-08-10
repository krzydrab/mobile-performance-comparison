//
//  utils.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 29/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

func generateRandomList(size: Int) -> [Double] {
    var res = Array<Double>(repeating: 0.0, count: size)
    for i in 0..<size {
        res[i] = Double.random(in: 0...1)
    }
    return res;
}

func generateRandomMatrix(rows: Int, cols: Int) -> [[Double]] {
    var res: [[Double]] = [[Double]]();
    for _ in 0..<rows {
        var row = [Double](repeating: 0.0, count: cols)
        for i in 0..<cols {
            row[i] = Double(Int.random(in: 0...10))
        }
        res.append(row)
    }
    return res;
}
