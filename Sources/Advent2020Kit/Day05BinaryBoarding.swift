//
//  Day05BinaryBoarding.swift
//
//
//  Created by David Paschich on 12/4/20.
//

import Foundation

// 871 is correct!
public func day05part1() {
    let lines = readLines()
    var highest = -1
    for line in lines {
        let id = seatID(line)
        highest = max(highest, id)
    }
    print(highest)
}

func seatID(_ input: String) -> Int {
    var result = 0
    for char in input {
        result *= 2
        switch char {
        case "B", "R": result += 1
        default: break
        }
    }
    return result
}
