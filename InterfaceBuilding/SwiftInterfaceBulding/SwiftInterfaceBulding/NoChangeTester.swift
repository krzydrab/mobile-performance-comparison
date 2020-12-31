//
//  NoChangeTester.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 30/12/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class NoChangeTester: Tester {
    private var nbOfItems: Int = 0
    private var rows: [RowData] = []
    
    override func generateRows() -> [RowData] {
        self.tests = [1, 250, 500, 750, 1000, 1250, 1500, 1750, 2000]
        self.nbOfItems = tests[testId];
        self.rows = self.generateDefaultRows(nbOfRows: self.nbOfItems);
        return self.rows;
    }

    
    override func updateRows() -> [RowData] {
//        let startingPoint = Date()
//        var itemsToChange = 5;
//        while(itemsToChange > 0) {
//            let i = Int.random(in: 0..<self.rows.count);
//            let j = Int.random(in: 0..<self.rows.count);
//            rows.swapAt(i, j);
//            itemsToChange -= 1;
//        }
//        self.timeToModify += startingPoint.timeIntervalSinceNow * -1;
        return self.rows;
    }
    
    override func testEnded(fps: Double) {
        self.results.append(TestResult(n: nbOfItems, timeToModify: timeToModify, fps: fps))
    }
}
