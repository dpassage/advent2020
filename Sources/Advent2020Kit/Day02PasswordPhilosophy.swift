//
//  Day02PasswordPhilosophy.swift
//
//
//  Created by David Paschich on 12/2/20.
//

import Foundation
import AdventLib

// 325 was too low
// 582 was correct!
public func day02part1() {
    let inputs = readLines()
    let passwordLines = inputs.compactMap(PasswordLine.init)
    let result = passwordLines.filter { $0.isValid }.count
    print(result)
}

// 729 was correct!
public func day02part2() {
    let inputs = readLines()
    let passwordLines = inputs.compactMap(PasswordLine.init)
    let result = passwordLines.filter { $0.isDay2Valid }.count
    print(result)
}

func readLines() -> [String] {
    var result: [String] = []
    while let line = readLine() {
        result.append(line)
    }
    return result
}

struct PasswordLine {
    var password: String
    var character: Character
    var low: Int
    var high: Int
    init?(_ string: String) {
        let pattern = #"(\d+)-(\d+) ([a-z]): ([a-z]+)"#
        let regex = try! Regex(pattern: pattern)
        guard let matches = regex.match(input: string),
              matches.count == 4 else {
            print("failed to parse \(string)!")
            return nil
        }
        low = Int(matches[0])!
        high = Int(matches[1])!
        character = matches[2].first!
        password = matches[3]
    }

    var isValid: Bool {
        let count = password.filter { $0 == character }.count
        return (low <= count) && (high >= count)
    }

    var isDay2Valid: Bool {
        let characters = [Character](password)
        let lowMatches = characters[low - 1] == character
        let highMatches = characters[high - 1] == character
        return lowMatches != highMatches
    }
}
