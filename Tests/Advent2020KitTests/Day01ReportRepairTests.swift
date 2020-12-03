//
//  Day01ReportRepairTests.swift
//  
//
//  Created by David Paschich on 12/2/20.
//

@testable import Advent2020Kit
import XCTest

class Day01ReportRepairTests: XCTestCase {
    func testSampleInput() {
        let sample = [
            1721,
            979,
            366,
            299,
            675,
            1456
        ]
        let result = reportRepair(inputs: sample, targetSum: 2020)
        XCTAssertEqual(result, 514579)
    }
}
