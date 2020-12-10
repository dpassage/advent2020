//
//  File.swift
//  
//
//  Created by David Paschich on 12/9/20.
//

import XCTest
@testable import Advent2020Kit

class EncodingErrorTests: XCTestCase {
    let sample =
    """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """
    func testSample() {
        let input = sample.components(separatedBy: "\n").compactMap(Int.init)
        let result = findEncodingError(input: input, preamble: 5)
        XCTAssertEqual(result, 127)
    }

    func testWeakness() {
        let input = sample.components(separatedBy: "\n").compactMap(Int.init)
        let target = findEncodingError(input: input, preamble: 5)
        let result = findWeakness(input: input, target: target)
        XCTAssertEqual(result, 62)

    }
}
