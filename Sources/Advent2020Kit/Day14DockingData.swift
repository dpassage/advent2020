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
    var computer = DockingDataComputer()
    computer.decoder(input: lines)
    let result = computer.sum()
    print(result)
}

// 4401465949086 was correct!
public func day14part2() {
    let lines = readLines()
    var computer = DockingDataComputer()
    computer.decoder2(input: lines)
    let result = computer.sum()
    print(result)
}

extension FixedWidthInteger {
    subscript(bit bit: Int) -> Self {
        get {
            return (self >> bit) & 1
        }
        set {
            if newValue == 0 {
                self &= ~(1 << bit)
            } else {
                self |= (1 << bit)
            }
        }
    }
}

enum DockingDataCommand: Equatable {
    case mask(String)
    case write(location: Int, value: Int)

    static let regex = try! Regex(pattern: #"^mem\[(\d+)\] = (\d+)$"#)
    init?(input: String) {
        // mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        if input.hasPrefix("mask") {
            let parts = input.components(separatedBy: " ")
            guard parts.count == 3 else { return nil }
            let string = parts[2]
            self = .mask(string)
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

    init() {

    }

    mutating func decoder(input: [String]) {
        let commands = input.compactMap(DockingDataCommand.init)

        var currentMask: String = ""

        for command in commands {
            switch command {
            case .mask(let mask): currentMask = mask
            case .write(location: let location, value: var value):
                for (bit, char) in currentMask.reversed().enumerated() {
                    switch char {
                    case "0": value[bit: bit] = 0
                    case "1": value[bit: bit] = 1
                    default: break
                    }
                }
                memory[location] = value
            }
        }
    }

    mutating func decoder2(input: [String]) {
        let commands = input.compactMap(DockingDataCommand.init)

        var currentMask: String = ""

        for command in commands {
            switch command {
            case .mask(let mask): currentMask = mask
            case .write(location: var location, value: let value):
                // first, apply the bits which are set directly
                for (bit, char) in currentMask.reversed().enumerated() {
                    switch char {
                    case "1": location[bit: bit] = 1
                    default: break
                    }
                }
                // now for the floating bits
                var locations = [location]
                for (bit, char) in currentMask.reversed().enumerated() where char == "X" {
                    var newLocations: [Int] = []
                    for location in locations {
                        var zero = location
                        zero[bit: bit] = 0
                        newLocations.append(zero)
                        var one = location
                        one[bit: bit] = 1
                        newLocations.append(one)
                    }
                    locations = newLocations
                }
                for location in locations {
                    print("writing to \(location)")
                    memory[location] = value
                }
            }
        }
    }

    func sum() -> Int {
        return memory.values.reduce(0, +)
    }
}
