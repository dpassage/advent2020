//
//  File.swift
//  
//
//  Created by David Paschich on 12/12/20.
//

import XCTest
@testable import Advent2020Kit

class RainRiskTests: XCTestCase {
    func testSample() {
        let sample =
        """
        F10
        N3
        F7
        R90
        F11
        """

        let input = sample.components(separatedBy: "\n")
//        let result = navigate(input: input)
//        XCTAssertEqual(result, 25)

        let result2 = navigate2(input: input)
        XCTAssertEqual(result2, 286)

    }
}
