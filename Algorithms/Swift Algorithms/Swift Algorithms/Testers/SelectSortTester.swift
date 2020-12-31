//
//  SelectSortTester.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 29/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class SelectSortTester:  AlgorithmTester {
    let arraySizes: [Int] = [100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000]

    override func testDescription(testSize: Int) -> String {
        return "N = \(arraySizes[testSize])";
    }
  
    override func test(testSize: Int) -> Double {
        var arrayToTest: [Double] = generateRandomList(size: arraySizes[testSize]);

        let startingPoint = Date()
        let arr = selectSort(list: &arrayToTest);
        let time = startingPoint.timeIntervalSinceNow * -1
        print(arr[0]);
        return time;
    }
}
