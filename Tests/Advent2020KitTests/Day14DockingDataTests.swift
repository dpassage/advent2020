//
//  File.swift
//  
//
//  Created by David Paschich on 12/18/20.
//

import XCTest
@testable import Advent2020Kit

class DockingDataTests: XCTestCase {
    func testParseMask() {
        let input = "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
        let result = DockingDataCommand(input: input)
        XCTAssertEqual(DockingDataCommand.mask([1: false, 6: true]), result)
    }

    func testParseWrite() {
        let input = "mem[7] = 101"
        let result = DockingDataCommand(input: input)
        XCTAssertEqual(DockingDataCommand.write(location: 7, value: 101), result)
    }

    let sampleInput =
        """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
        """
    func testSample() {
        let computer = DockingDataComputer(input: sampleInput.components(separatedBy: "\n"))
        let result = computer.sum()
        XCTAssertEqual(result, 165)
    }
}

