//
//  Day01ReportRepair.swift
//  
//
//  Created by David Paschich on 12/2/20.
//

import Foundation

func day01part1() {

}


func reportRepair(inputs: [Int], targetSum: Int) -> Int {
    let sortedInputs = inputs.sorted()

    var low = sortedInputs.startIndex
    var high = sortedInputs.index(before: sortedInputs.endIndex)

    while low < high {
        let sum = inputs[low] + inputs[high]
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
