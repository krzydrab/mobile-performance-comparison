//
//  SelectSortTester.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 29/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class SelectSortTester:  AlgorithmTester {
    let arraySizes: [Int] = [10, 50, 100, 500, 1000, 5000, 10000, 20000, 30000, 40000]

    override func testDescription(testSize: Int) -> String {
        return "N = \(arraySizes[testSize])";
    }
  
    override func test(testSize: Int) -> Double {
        var arrayToTest: [Double] = generateRandomList(size: arraySizes[testSize]);

        let startingPoint = Date()
        selectSort(list: &arrayToTest);
        return startingPoint.timeIntervalSinceNow * -1;
    }
}
