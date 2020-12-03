//
//  Day03TobogganTrajectoryTests.swift
//
//
//  Created by David Paschich on 12/3/20.
//

import XCTest
@testable import Advent2020Kit

class Day03TobogganTrajectoryTests: XCTestCase {
    func testDay1Sample() {
        let sample = """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """

        let map = TobogganMap(lines: sample.split(separator: "\n").map { String($0) })
        let trees = map.traverse(right: 3, down: 1)
        XCTAssertEqual(trees, 7)
    }
}
