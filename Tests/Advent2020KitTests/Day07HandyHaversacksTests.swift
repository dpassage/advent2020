//
//  File.swift
//  
//
//  Created by David Paschich on 12/6/20.
//

import XCTest
@testable import Advent2020Kit

class HandyHaversacksTests: XCTestCase {
    let sample = """
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
    """
    func testSample() {
        let lines = sample.split(separator: "\n").map(String.init)
        let result = countContainingBags(lines: lines, bag: "shiny gold")
        XCTAssertEqual(result, 4)
    }

    func testSamplePart2() {
        let rules = sample.split(separator: "\n").map(String.init).compactMap(BagRule.init(line:))
        let result = countContainedBags(rules: rules, bag: "shiny gold")
        XCTAssertEqual(result, 32)
    }

    func testAnotherExample() {
        let input =
        """
        shiny gold bags contain 2 dark red bags.
        dark red bags contain 2 dark orange bags.
        dark orange bags contain 2 dark yellow bags.
        dark yellow bags contain 2 dark green bags.
        dark green bags contain 2 dark blue bags.
        dark blue bags contain 2 dark violet bags.
        dark violet bags contain no other bags.
        """
        let rules = input.split(separator: "\n").map(String.init).compactMap(BagRule.init(line:))
        let result = countContainedBags(rules: rules, bag: "shiny gold")
        XCTAssertEqual(result, 126)
    }

    func testParseLine() {
        let line = "faded blue bags contain no other bags."
        let rule = BagRule(line: line)
        XCTAssertEqual(rule?.containing, "faded blue")
        XCTAssertEqual(rule?.contained.count, 0)
    }

    func testParseWithSubests() {
        let line = "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags."
        let rule = BagRule(line: line)
        XCTAssertEqual(rule?.containing, "vibrant plum")
        XCTAssertEqual(rule?.contained.count, 2)
        XCTAssertEqual(rule?.contained[0].0, 5)
        XCTAssertEqual(rule?.contained[0].1, "faded blue")
        XCTAssertEqual(rule?.contained[1].0, 6)
        XCTAssertEqual(rule?.contained[1].1, "dotted black")
    }
}
