//
//  Day04PassportProcessing.swift
//
//
//  Created by David Paschich on 12/3/20.
//

import Foundation

// 247 was correct!
public func day04part1() {
    let lines = readLines()
    let passports = lines.joined(separator: "\n")
    let valid = validatePassports(passports)
    print(valid)
}

func validatePassports(_ input: String) -> Int {
    let passports = (input as NSString).components(separatedBy: "\n\n")

    return passports.map(validatePassport(_:)).filter { $0 }.count
}

let expectedFields: Set<String> = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
]

func validatePassport(_ input: String) -> Bool {
    let parts = input.split(whereSeparator: { $0.isWhitespace })
    let fields = parts.map { String($0.prefix(while: { $0 != ":" })) }
    let withoutCountry = fields.filter { $0 != "cid" }
    let fieldSet = Set(withoutCountry)
    return fieldSet == expectedFields
}
