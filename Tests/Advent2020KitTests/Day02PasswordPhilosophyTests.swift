//
//  Day02PasswordPhilosophyTests.swift
//
//
//  Created by David Paschich on 12/3/20.
//

@testable import Advent2020Kit
import XCTest

class Day02PasswordPhilosophyTests: XCTestCase {
    func testParseAndCheck() throws {
        let testCases: [(String, Bool)] = [
            ("1-3 a: abcde", true),
            ("1-3 b: cdefg", false),
            ("2-9 c: ccccccccc", true)
        ]
        for (testCase, expected) in testCases {
            let passwordLine = PasswordLine(testCase)!
            XCTAssertEqual(passwordLine.isValid, expected)
        }
    }

    func testDay2ParseAndCheck() throws {
        let testCases: [(String, Bool)] = [
            ("1-3 a: abcde", true),
            ("1-3 b: cdefg", false),
            ("2-9 c: ccccccccc", false)
        ]
        for (testCase, expected) in testCases {
            let passwordLine = PasswordLine(testCase)!
            XCTAssertEqual(passwordLine.isDay2Valid, expected)
        }
    }
}
