//
//  File.swift
//  
//
//  Created by David Paschich on 12/9/20.
//

import Foundation

// 3000 was correct!
public func day10part1() {
    let inputs = readLines().compactMap(Int.init)
    print(joltchain(inputs: inputs))
}

// 193434623148032 was correct!
public func day10part2() {
    let inputs = readLines().compactMap(Int.init)
    print(joltCombos(inputs: inputs))
}

func joltchain(inputs: [Int]) -> Int {
    let chain = inputs.sorted()
    var oneJumps = 0
    var twoJumps = 0
    var threeJumps = 0
    var lastAdapter = 0
    for adapter in chain {
        print("adapter \(adapter)")
        let difference = adapter - lastAdapter
        if difference == 1 {
            oneJumps += 1
        } else if difference == 3 {
            threeJumps += 1
        } else if difference == 2 {
            twoJumps += 1
        }
        lastAdapter = adapter
    }
    print("oneJumps \(oneJumps), twoJumps \(twoJumps), threeJumps \(threeJumps)")
    return oneJumps * (threeJumps + 1)
}

func joltCombos(inputs: [Int]) -> Int {
    var chain = inputs.sorted()
    chain.append(chain.last! + 3)
    var lastRun = [0]
    var lastAdapter = 0
    var runsFound: [Int] = []
    for adapter in chain {
        print("adapter \(adapter)")
        let difference = adapter - lastAdapter
        if difference == 1 {
            lastRun.append(adapter)
        } else if difference == 3 {
            print("lastRun length \(lastRun.count)")
            runsFound.append(lastRun.count)
            lastRun = [adapter]
        }
        lastAdapter = adapter
    }

    print("runs found: \(runsFound)")
    var combos = 1
    for run in runsFound {
        switch run {
        case 1: break
        case 2: combos *= 1
        case 3: combos *= 2
        case 4: combos *= 4
        case 5: combos *= 7
        default: fatalError("run length \(run)")
        }
    }
    return combos
}
