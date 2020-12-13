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
