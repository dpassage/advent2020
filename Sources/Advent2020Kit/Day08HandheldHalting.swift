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

        init(_ input: [String]) {
            instructions = input.compactMap(Instr.init)
        }

        mutating func step() {
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
            return accumulator
        }
    }
}
