//
//  File.swift
//  
//
//  Created by David Paschich on 12/18/20.
//

import Foundation
import AdventLib

// 17780407703020 was too high
// 17765746710228 was correct!
public func day14part1() {
    let lines = readLines()
    let computer = DockingDataComputer(input: lines)
    let result = computer.sum()
    print(result)
}

enum DockingDataCommand: Equatable {
    case mask([Int: Bool])
    case write(location: Int, value: Int)

    static let regex = try! Regex(pattern: #"^mem\[(\d+)\] = (\d+)$"#)
    init?(input: String) {
        // mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        if input.hasPrefix("mask") {
            let parts = input.components(separatedBy: " ")
            guard parts.count == 3 else { return nil }
            let string = parts[2]
            var mask: [Int: Bool] = [:]
            for (index, char) in string.reversed().enumerated() {
                switch char {
                case "0": mask[index] = false
                case "1": mask[index] = true
                default: break
                }
            }
            self = .mask(mask)
            return
        } else if let matches = DockingDataCommand.regex.match(input: input),
           let location = Int(matches[0]),
           let value = Int(matches[1]) {
            self = .write(location: location, value: value)
            return
        } else {
            return nil
        }
    }
}

struct DockingDataComputer {
    var memory: [Int: Int] = [:]

    init(input: [String]) {
        let commands = input.compactMap(DockingDataCommand.init)

        var currentMask: [Int: Bool] = [:]

        for command in commands {
            switch command {
            case .mask(let mask): currentMask = mask
            case .write(location: let location, value: var value):
                for (bit, bool) in currentMask {
                    let modifier = 1 << bit
                    if bool {
                        value |= modifier
                    } else {
                        if value & modifier != 0 {
                            value -= modifier
                        }
                    }
                }

                memory[location] = value
            }
        }
    }

    func sum() -> Int {
        return memory.values.reduce(0, +)
    }
}
