//
//  File.swift
//  
//
//  Created by David Paschich on 12/9/20.
//

import Foundation

// 21806024 was correct!
public func day09part1() {
    let input = readLines().compactMap(Int.init)
    let result = findEncodingError(input: input, preamble: 25)
    print(result)
}

// 2986195 was correct!
public func day09part2() {
    let input = readLines().compactMap(Int.init)
    let target = findEncodingError(input: input, preamble: 25)
    let result = findWeakness(input: input, target: target)
    print(result)
}

func findEncodingError(input: [Int], preamble: Int) -> Int {
    guard input.count > (preamble + 1) else { return -1 }
    let preambleNumbers = input.prefix(preamble).sorted()
    let target = input[preamble]

    if reportRepair(inputs: preambleNumbers, targetSum: target) == -1 {
        return target
    } else {
        var nextInput = input
        nextInput.removeFirst()
        return findEncodingError(input: nextInput, preamble: preamble)
    }
}

func findWeakness(input: [Int], target: Int) -> Int {

    lowIndex: for low in input.indices {
        var sum = input[low]
        for high in input.index(after: low)..<input.endIndex {
            sum += input[high]
            if sum == target {
                let range = low...high
                let numbers = input[range].sorted()
                return  numbers.first! + numbers.last!
            } else if sum > target {
                continue lowIndex
            }
        }
    }

    return -1
}
