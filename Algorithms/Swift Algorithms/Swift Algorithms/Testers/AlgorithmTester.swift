//
//  AlgorithmTester.swift
//  Swift Algorithms
//
//  Created by Krzysztof Drab on 29/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

struct Result {
    var testSize: Int
    var description: String
    var time: Double
}

class AlgorithmTester {
    func testDescription(testSize: Int) -> String {
        preconditionFailure("This method must be overridden")
    };
    func test(testSize: Int) -> Double {
        preconditionFailure("This method must be overridden")
    };

    func testAll(fromTestSize: Int, toTestSize: Int) -> [Result] {
        let size = toTestSize - fromTestSize
        var res: [Result] = [Result]()
        for i in 0...size {
            let testSize: Int = fromTestSize + i;
            res.append(Result(
                testSize: testSize,
                description: testDescription(testSize: testSize),
                time: test(testSize: testSize)
            ));

            print("Test \(testSize), \(i+1) / \(size) completed");
        }
        return res;
    }
}
