//
//  AckermannFunctionTester.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 29/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class AckermannFunctionTester:  AlgorithmTester {

    override func testDescription(testSize: Int) -> String {
        return "m = 3, n = \(3 + testSize)";
    }

  
    override func test(testSize: Int) -> Double {
        let m: Int = 3;
        let n: Int = 3 + testSize;

        let startingPoint = Date()
        ackermannFunction(m, n);
        return startingPoint.timeIntervalSinceNow * -1;
    }
}
