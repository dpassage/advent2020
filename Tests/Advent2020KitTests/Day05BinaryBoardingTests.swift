//
//  Day05BinaryBoardingTests.swift
//
//
//  Created by David Paschich on 12/4/20.
//

import XCTest
@testable import Advent2020Kit

class Day05BinaryBoardingTests: XCTestCase {
    func testSamples() {
        let testcases: [(String, Int)] = [
            ("FBFBBFFRLR", 357),
            ("BFFFBBFRRR", 567),
            ("FFFBBBFRRR", 119),
            ("BBFFBBFRLL", 820)
        ]

        for (input, id) in testcases {
            XCTAssertEqual(seatID(input), id)
        }
    }
}
