//
//  File.swift
//  
//
//  Created by David Paschich on 12/13/20.
//

import XCTest
@testable import Advent2020Kit

class ShuttleSearchTests: XCTestCase {
    func testSample() {
        let busses = "7,13,x,x,59,x,31,19"
        let result = nextBus(timestamp: 939, busses: busses)
        XCTAssertEqual(result, 295)
    }
}
