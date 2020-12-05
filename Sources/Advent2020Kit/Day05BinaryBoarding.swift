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

// 640 was correct answer!
public func day05part2() {
    let lines = readLines()
    var seats: [Int] = []
    for line in lines {
        let id = seatID(line)
        seats.append(id)
    }
    seats.sort()
    var prevSeat = seats[0]
    for i in 1..<seats.count {
        if seats[i] != prevSeat + 1 {
            print(seats[i] - 1)
            break
        }
        prevSeat = seats[i]
    }
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
