//
//  VisibilityChangeTester.swift
//  SwiftInterfaceBulding
//
//  Created by Krzysztof Drab on 29/12/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import Foundation

class VisibilityChangeTester: Tester {
    private var visibleRowsIds: [Int] = []
    private var invisibleRowsIds: [Int] = []
    private var nbOfItems: Int = 0
    private var nbOfChanges: Int = 0
    private var rows: [RowData] = []
    
    override func generateRows() -> [RowData] {
        self.tests = [5, 25, 50, 75, 100, 125, 150, 175, 200];
        self.nbOfItems = 500;
        self.nbOfChanges = tests[testId];
        let totalNbOfItems: Int = self.nbOfChanges + self.nbOfItems;
        self.rows = self.generateDefaultRows(nbOfRows: totalNbOfItems);
        self.visibleRowsIds = Array(0..<(totalNbOfItems));
        self.visibleRowsIds.shuffle()
        self.invisibleRowsIds = Array(self.visibleRowsIds[0..<self.nbOfChanges]);
        self.invisibleRowsIds.forEach { self.rows[$0].visibility = false };
        self.visibleRowsIds = Array(self.visibleRowsIds[self.nbOfChanges...]);
        return self.rows.filter(\.visibility);
    }
    
    override func updateRows() -> [RowData] {
        let startingPoint = Date()
        self.invisibleRowsIds.forEach { self.rows[$0].visibility = true };
        self.visibleRowsIds = self.invisibleRowsIds + self.visibleRowsIds;
        self.invisibleRowsIds = Array(self.visibleRowsIds[(self.visibleRowsIds.count - self.nbOfChanges)...]);
        self.visibleRowsIds = Array(self.visibleRowsIds[0..<(self.visibleRowsIds.count - self.nbOfChanges)]);
        self.invisibleRowsIds.forEach { self.rows[$0].visibility = false };
        self.timeToModify += startingPoint.timeIntervalSinceNow * -1;
        return self.rows.filter(\.visibility);
    }
    
    override func testEnded(fps: Double) {
        self.results.append(TestResult(n: nbOfChanges, timeToModify: timeToModify, fps: fps))
    }
}
