//
//  File.swift
//  
//
//  Created by David Paschich on 12/6/20.
//

import Foundation

// 139 was correct!
public func day07part1() {
    let lines = readLines()
    let result = countContainingBags(lines: lines, bag: "shiny gold")
    print(result)
}

// 58175 was correct!
public func day07part2() {
    let lines = readLines()
    let rules = lines.compactMap(BagRule.init(line:))
    let result = countContainedBags(rules: rules, bag: "shiny gold")
    print(result)
}

func countContainingBags(lines: [String], bag: String) -> Int {
    let rules = lines.compactMap(BagRule.init(line:))

    var found = Set<String>()
    var stack: [String] = [bag]
    while !stack.isEmpty {
        let next = stack.removeFirst()
        for rule in rules {
            for contained in rule.contained {
                if contained.1 == next {
                    found.insert(rule.containing)
                    stack.append(rule.containing)
                }
            }
        }
    }
    return found.count
}

func countContainedBags(rules: [BagRule], bag: String) -> Int {
    var result = 0

    let rule = rules.first(where: { $0.containing == bag })!
    for contained in rule.contained {
        let containedCount = contained.0 * (1 + countContainedBags(rules: rules, bag: contained.1))
        result += containedCount
    }
    return result
}

struct BagRule {
    var containing: String
    var contained: [(Int, String)] = []

    //vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    //faded blue bags contain no other bags.

    init?(line: String) {
        var words = line.split(separator: " ").map(String.init)

        containing = "\(words[0]) \(words[1])"
        words.removeFirst(4) //
        if words[0] == "no" { return }

        while !words.isEmpty {
            let count = Int(words.removeFirst())!
            let color = "\(words.removeFirst()) \(words.removeFirst())"
            _ = words.removeFirst()
            contained.append((count, color))
        }
    }
}
