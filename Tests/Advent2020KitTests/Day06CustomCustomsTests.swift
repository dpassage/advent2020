//
//  Day06CustomCustomsTests.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import XCTest
@testable import Advent2020Kit

class Day06CustomCustomsTests: XCTestCase {
    let sample =
    """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    func testSample() {
        let count = countCustomsResponses(sample)
        XCTAssertEqual(count, 11)
    }

    func testSampleEveryone() {
        let count = countEverybodyResponded(sample)
        XCTAssertEqual(count, 6)
    }

    func testCountEverybodyGroup() {
        let count = countEverybodyGroup(input: "abc")
        XCTAssertEqual(count, 3)
    }
}
