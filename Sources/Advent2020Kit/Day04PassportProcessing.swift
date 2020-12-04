//
//  Day04PassportProcessing.swift
//
//
//  Created by David Paschich on 12/3/20.
//

import Foundation
import AdventLib

// 247 was correct!
public func day04part1() {
    let lines = readLines()
    let passports = lines.joined(separator: "\n")
    let valid = validatePassports(passports)
    print(valid)
}

// 145 was correct!
public func day04part2() {
    let lines = readLines()
    let passports = lines.joined(separator: "\n")
    let valid = deepValidatePassports(passports)
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

func deepValidatePassports(_ input: String) -> Int {
    let passports = (input as NSString).components(separatedBy: "\n\n")

    return passports.map(deepValidatePassport(_:)).filter { $0 }.count
}

func deepValidatePassport(_ input: String) -> Bool {
    let parts = input.split(whereSeparator: { $0.isWhitespace })

    let fields: [(String, String)] = parts.map {
        let pieces = $0.split(separator: ":")
        return (String(pieces[0]), String(pieces[1]))
    }.filter { $0.0 != "cid" }

    if fields.count != 7 { return false }
    for (field, value) in fields {
        switch field {
        case "byr": if !validateBirthYear(value) { return false }
        case "iyr": if !validateIssueYear(value) { return false }
        case "eyr": if !validateExpYear(value) { return false }
        case "hgt": if !validateHeight(value) { return false }
        case "hcl": if !validateHairColor(value) { return false }
        case "ecl": if !validateEyeColor(value) { return false }
        case "pid": if !validatePassportID(value) { return false }
        default: return false
        }
    }
    return true
}

//byr (Birth Year) - four digits; at least 1920 and at most 2002.
func validateBirthYear(_ input: String) -> Bool {
    guard let year = Int(input) else { return false }
    return (1920...2002).contains(year)
}

//iyr (Issue Year) - four digits; at least 2010 and at most 2020.
func validateIssueYear(_ input: String) -> Bool {
    guard let year = Int(input) else { return false }
    return (2010...2020).contains(year)
}

//eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
func validateExpYear(_ input: String) -> Bool {
    guard let year = Int(input) else { return false }
    return (2020...2030).contains(year)
}

//hgt (Height) - a number followed by either cm or in:
//  If cm, the number must be at least 150 and at most 193.
//  If in, the number must be at least 59 and at most 76.
func validateHeight(_ input: String) -> Bool {
    if input.hasSuffix("cm") {
        guard let height = Int(input.dropLast(2)),
              (150...193).contains(height) else { return false }
        return true
    } else if input.hasSuffix("in") {
        guard let height = Int(input.dropLast(2)),
              (59...76).contains(height) else { return false }
        return true
    } else {
        return false
    }
}

//hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
let hairRegex = try! Regex(pattern: "^#[0-9a-f]{6}$")
func validateHairColor(_ input: String) -> Bool {
    return hairRegex.match(input: input) != nil
}

//ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
let eyeColors: Set<String> = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
func validateEyeColor(_ input: String) -> Bool {
    return eyeColors.contains(input)
}

//pid (Passport ID) - a nine-digit number, including leading zeroes.
func validatePassportID(_ input: String) -> Bool {
    return input.count == 9 && input.allSatisfy { $0.isASCII && $0.isNumber }
}
