//
//  Swift_AlgorithmsTests.swift
//  Swift AlgorithmsTests
//
//  Created by Krzysztof Drab on 17/05/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import XCTest
@testable import Swift_Algorithms

class Swift_AlgorithmsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGaussElimination() {
        var input: [[Double]] = [
            [ 4, -2, 4, -2, 8 ],
            [ 3, 1, 4, 2, 7 ],
            [ 2, 4, 2, 1, 10 ],
            [ 2, -2, 4, 2, 2 ]
        ];
        let expected: [Double] = [ -1, 2, 3, -2 ];
        let actual: [Double] = gaussElimination(matrix: &input);
        XCTAssertEqual(actual[0], expected[0], accuracy: 0.00000001);
        for i in 0...3 {
            XCTAssertEqual(actual[i], expected[i], accuracy: 0.00000001);
        }
    }
    
    
    func testAckermannFunctionWithSmallInput() {
        XCTAssertEqual(ackermannFunction(2, 3), 9);
    }
    
    func testAckermannFunctionWithMediumInput() {
        XCTAssertEqual(ackermannFunction(3, 5), 253);
    }
    
    func testSelectSort() {
        var input: [Double] = [0.2, 11, 3.14, -1, 1, 0.21, 10.999];
        let expected: [Double] = [-1, 0.2, 0.21, 1, 3.14, 10.999, 11];
        let actual = selectSort(list: &input);
        XCTAssertEqual(actual, expected);
    }
}
