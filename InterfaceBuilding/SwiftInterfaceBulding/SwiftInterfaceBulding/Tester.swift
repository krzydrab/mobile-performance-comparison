//
//  tester.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 29/12/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

struct TestResult {
    var n: Int
    var timeToModify: Double
    var fps: Double
}

struct RowData: Identifiable {
    var id: Int
//    var id = UUID() It is slower because comparison is more expensive
    var value: Double
    var visibility = true
}

class Tester {
    var results: [TestResult] = [];
    var tests: [Int] = [];
    var timeToModify: Double = 0.0;
    var testId: Int = -1;

    func generateRows() -> [RowData] {
        preconditionFailure("This method must be overridden")
    }
    func updateRows() -> [RowData] {
        preconditionFailure("This method must be overridden")
    }
    func testEnded(fps: Double) {
        preconditionFailure("This method must be overridden")
    }

    func generateDefaultRows(nbOfRows: Int) -> [RowData] {
        let arr = Array<Double>(repeating: 0.0, count: nbOfRows)
        return arr.map { _ in
            RowData(id: Int.random(in: 0...10000), value: Double.random(in: 0...1))
        };
    }

    func nextTest() -> [RowData] {
      self.testId += 1;
      self.timeToModify = 0.0;
      return self.generateRows();
    }

    func isCompleted() -> Bool {
      return self.testId >= self.tests.count - 1;
    }
}
