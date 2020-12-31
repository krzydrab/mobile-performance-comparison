//
//  FullRebuildTester.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 29/12/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class FullRebuildTester: Tester {
    private var nbOfItems: Int = 0
    private var rows: [RowData] = []
    
    override func generateRows() -> [RowData] {
        self.tests = [1, 250, 500, 750, 1000, 1250, 1500, 1750, 2000]
        self.nbOfItems = tests[testId];
        self.rows = self.generateDefaultRows(nbOfRows: self.nbOfItems);
        return self.rows;
    }

    override func updateRows() -> [RowData] {
        let startingPoint = Date()
        var i = 0;
        while(i < self.rows.count) {
            self.rows[i] = RowData(id: Int.random(in: 1...10000), value: Double.random(in: 0...1))
            i += 1
        }
        self.timeToModify += startingPoint.timeIntervalSinceNow * -1;
        return self.rows;
    }
    
    override func testEnded(fps: Double) {
        self.results.append(TestResult(n: nbOfItems, timeToModify: timeToModify, fps: fps))
    }
}
