//
//  Day01ReportRepair.swift
//  
//
//  Created by David Paschich on 12/2/20.
//

import Foundation

public func day01part1() {
    let inputs = readInts().sorted()

    let result = reportRepair(inputs: inputs, targetSum: 2020)
    print(result)
}

public func day01part2() {
    let inputs = readInts().sorted()
    let result = repair3(inputs: inputs, targetSum: 2020)
    print(result)
}

func readInts() -> [Int] {
    var inputs: [Int] = []
    while let line = readLine(),
          let value = Int(line) {
        inputs.append(value)
    }
    return inputs
}

func reportRepair(inputs: [Int], targetSum: Int) -> Int {
    var low = inputs.startIndex
    var high = inputs.index(before: inputs.endIndex)

    while low < high {
        let sum = inputs[low] + inputs[high]
        print("values: low \(inputs[low]) high \(inputs[high]) sum \(sum)")
        if sum == targetSum {
            return inputs[low] * inputs[high]
        } else if sum < targetSum {
            inputs.formIndex(after: &low)
        } else { // sum > targetSum
            inputs.formIndex(before: &high)
        }
    }

    return -1
}

func repair3(inputs: [Int], targetSum: Int) -> Int {
    var inputs = inputs
    while let lastNumber = inputs.popLast() {
        print("lastNumber \(lastNumber) remaining \(inputs)")
        let remaining = targetSum - lastNumber
        guard remaining > 0 else { continue }

        let inner = reportRepair(inputs: inputs, targetSum: remaining)
        if inner == -1 { continue }
        return lastNumber * inner
    }

    return -1
}
