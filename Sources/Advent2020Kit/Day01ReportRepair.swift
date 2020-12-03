//
//  Day01ReportRepair.swift
//  
//
//  Created by David Paschich on 12/2/20.
//

import Foundation

public func day01part1() {
    var inputs: [Int] = []
    while let line = readLine(),
          let value = Int(line) {
        inputs.append(value)
    }

    let result = reportRepair(inputs: inputs, targetSum: 2020)
    print(result)
}

func reportRepair(inputs: [Int], targetSum: Int) -> Int {
    let sortedInputs = inputs.sorted()

    var low = sortedInputs.startIndex
    var high = sortedInputs.index(before: sortedInputs.endIndex)

    while low < high {
        let sum = sortedInputs[low] + sortedInputs[high]
        print("values: low \(sortedInputs[low]) high \(sortedInputs[high]) sum \(sum)")
        if sum == targetSum {
            return sortedInputs[low] * sortedInputs[high]
        } else if sum < targetSum {
            sortedInputs.formIndex(after: &low)
        } else { // sum > targetSum
            sortedInputs.formIndex(before: &high)
        }
    }

    return -1
}
