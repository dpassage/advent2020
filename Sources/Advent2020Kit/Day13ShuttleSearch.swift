//
//  File.swift
//  
//
//  Created by David Paschich on 12/13/20.
//

import Foundation

// 2215 was correct!
public func day13part1() {
    let busses = "19,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,823,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,443,x,x,x,x,x,37,x,x,x,x,x,x,13"
    let result = nextBus(timestamp: 1005162, busses: busses)
    print(result)
}

// 1058443396696792 was correct!
public func day13part2() {
    let busses = "19,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,823,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,443,x,x,x,x,x,37,x,x,x,x,x,x,13"
    let result = busSync(busses)
    print(result)
}

func nextBus(timestamp: Int, busses: String) -> Int {
    let busIds = busses.components(separatedBy: ",").compactMap(Int.init)
    var bestBusId = -1
    var shortestWait = Int.max

    for bus in busIds {
        let wait = bus - (timestamp % bus)
        if wait < shortestWait {
            bestBusId = bus
            shortestWait = wait
        }
    }

    return bestBusId * shortestWait
}

func busSync(_ busses: String) -> Int {
    // first build an array of offsets and divisors
    var offsets: [(offset: Int, divisor: Int)] = []
    let inputs = busses.components(separatedBy: ",")
    for (index, string) in inputs.enumerated() {
        if let divisor = Int(string) {
            var offset = (divisor - index) % divisor
            while offset < 0 { offset += divisor }
            offsets.append((offset, divisor))
        }
    }

    print(offsets)
    // sort so largest divisor is first
    offsets.sort { $0.divisor > $1.divisor }
    print(offsets)

    let (firstOffset, firstDivisor) = offsets.removeFirst()

    var result = firstOffset
    var currentDivisor = firstDivisor

    while !offsets.isEmpty {
        let (nextOffset, nextDivisor) = offsets.removeFirst()

        while result % nextDivisor != nextOffset {
            result += currentDivisor
        }
        currentDivisor *= nextDivisor
    }

    return result
}

