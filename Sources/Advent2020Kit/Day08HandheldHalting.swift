//
//  File.swift
//  
//
//  Created by David Paschich on 12/7/20.
//

import Foundation

// 1684 was correct!
public func day08part1() {
    let lines = readLines()
    var console = HandheldHalting.Console(lines)
    let result = console.run()
    print(result)
}

public func day08part2() {
    let lines = readLines()
    let console = HandheldHalting.Console(lines)
    let startingInstructions = console.instructions

    for index in (0..<startingInstructions.count).reversed() {
        var changedInstructions = startingInstructions
        switch changedInstructions[index].opCode {
        case .nop: changedInstructions[index].opCode = .jmp
        case .jmp: changedInstructions[index].opCode = .nop
        default: continue
        }
        print("changed instr at \(index)")
        var console = HandheldHalting.Console(instructions: changedInstructions)
        let result = console.run()
        if console.halted && console.crashed {
            print(result)
            return
        } else {
            print("looped, trying again")
        }
    }
}

enum HandheldHalting {
    enum OpCode: String {
        case nop
        case acc
        case jmp
        case hlt // used to detect already executed instructions
    }

    struct Instr {
        var opCode: OpCode
        var arg: Int

        init?(_ input: String) {
            let parts = input.components(separatedBy: " ")
            guard let opCode = OpCode(rawValue: parts[0]),
                  let arg = Int(parts[1]) else { return nil }
            self.opCode = opCode
            self.arg = arg
        }
    }

    struct Console {
        var instructions: [Instr]
        var pc = 0
        var accumulator = 0
        var halted = false
        var crashed = false

        init(_ input: [String]) {
            instructions = input.compactMap(Instr.init)
        }

        init(instructions: [Instr]) {
            self.instructions = instructions
        }

        mutating func step() {
            guard instructions.indices.contains(pc) else {
                print("off the end!")
                halted = true
                crashed = true
                return
            }
            let instr = instructions[pc]
            instructions[pc].opCode = .hlt
            switch instr.opCode {
            case .nop: pc += 1
            case .acc:
                accumulator += instr.arg
                pc += 1
            case .jmp:
                pc += instr.arg
            case .hlt:
                halted = true
            }
        }

        mutating func run() -> Int {
            while !halted {
                step()
            }
            print("halted at pc \(pc)")
            return accumulator
        }
    }
}
