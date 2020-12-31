//
//  SwapTester.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 29/12/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class SwapTester: Tester {
    private var nbOfItems: Int = 0
    private var nbOfChanges: Int = 0
    private var rows: [RowData] = []
    
    override func generateRows() -> [RowData] {
        self.tests = [5, 25, 50, 75, 100, 125, 150, 175, 200];
        self.nbOfItems = 800;
        self.nbOfChanges = tests[testId];
        self.rows = self.generateDefaultRows(nbOfRows: self.nbOfItems);
        return self.rows;
    }

    
    override func updateRows() -> [RowData] {
        let startingPoint = Date()
        var itemsToChange = self.nbOfChanges;
        while(itemsToChange > 0) {
            let i = Int.random(in: 0..<self.rows.count);
            let j = Int.random(in: 0..<self.rows.count);
            rows.swapAt(i, j);
            itemsToChange -= 1;
        }
        self.timeToModify += startingPoint.timeIntervalSinceNow * -1;
        return self.rows;
    }
    
    override func testEnded(fps: Double) {
        self.results.append(TestResult(n: nbOfChanges, timeToModify: timeToModify, fps: fps))
    }
}
