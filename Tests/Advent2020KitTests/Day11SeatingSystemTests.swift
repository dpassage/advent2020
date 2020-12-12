//
//  File.swift
//  
//
//  Created by David Paschich on 12/11/20.
//

import XCTest
@testable import Advent2020Kit

class SeatingSystemTests: XCTestCase {
    func testFillSeats() {
        let input =
        """
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """
        let result = fillSeats(input: input, iterate: iterate)
        XCTAssertEqual(result, 37)

        let result2 = fillSeats(input: input, iterate: iterate2)
        XCTAssertEqual(result2, 26)
    }
}
