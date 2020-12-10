//
//  File.swift
//  
//
//  Created by David Paschich on 12/9/20.
//

import XCTest
@testable import Advent2020Kit

class AdapterArrayTests: XCTestCase {
    func testSample1() {
        let sample =
        """
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
        """
        let inputs = sample.components(separatedBy: "\n").compactMap(Int.init)
        let result = joltchain(inputs: inputs)
        XCTAssertEqual(result, 35)
        let combos = joltCombos(inputs: inputs)
        XCTAssertEqual(combos, 8)
    }

    func testSample2() {
        let sample =
        """
        28
        33
        18
        42
        31
        14
        46
        20
        48
        47
        24
        23
        49
        45
        19
        38
        39
        11
        1
        32
        25
        35
        8
        17
        7
        9
        4
        2
        34
        10
        3
        """
        let inputs = sample.components(separatedBy: "\n").compactMap(Int.init)
        let result = joltchain(inputs: inputs)
        XCTAssertEqual(result, 220)
        let combos = joltCombos(inputs: inputs)
        XCTAssertEqual(combos, 19208)
    }
}
