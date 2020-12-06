//
//  Day06CustomCustoms.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation

// 6703 was correct!
public func day06part1() {
    let lines = readLines()
    let input = lines.joined(separator: "\n")
    let result = countCustomsResponses(input)
    print(result)
}

// 3430 was correct!
public func day06part2() {
    let lines = readLines()
    let input = lines.joined(separator: "\n")
    let result = countEverybodyResponded(input)
    print(result)
}

func countCustomsResponses(_ input: String) -> Int {
    let groups = (input as NSString).components(separatedBy: "\n\n")
    let counts = groups.map(countResponse(input:))

    return counts.reduce(0, +)
}

private func countResponse(input: String) -> Int {
    let chars = Set<Character>(input.filter { $0.isLetter })
    return chars.count
}

func countEverybodyResponded(_ input: String) -> Int {
    let groups = (input as NSString).components(separatedBy: "\n\n")
    let counts = groups.map(countEverybodyGroup(input:))
    return counts.reduce(0, +)
}

let allLetterSet: Set<Character> = Set("abcdefghijklmnopqrstuvwxyz")
func countEverybodyGroup(input: String) -> Int {
    let people = input.split(separator: "\n").map(String.init)
    let peopleSets = people.map { Set($0) }

    let everyoneSet = peopleSets.reduce(allLetterSet) { (result, next) -> Set<Character> in
        return result.intersection(next)
    }

    return everyoneSet.count
}
