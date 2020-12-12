//
//  File.swift
//  
//
//  Created by David Paschich on 12/12/20.
//

import Foundation
import AdventLib

// 1603 was correct!
public func day12part1() {
    let lines = readLines()
    let result = navigate(input: lines)
    print(result)
}

// 52866 was correct!
public func day12part2() {
    let lines = readLines()
    let result = navigate2(input: lines)
    print(result)
}

func navigate(input: [String]) -> Int {
    var location = Point(x: 0, y: 0) // y axis points north
    var direction = 90 // in degrees, 0 is north

    for line in input {
        let command = line.first!
        let amount = Int(line.dropFirst())!

        print("line \(line) location \(location) direction \(direction)")
        switch command {
        case "N":
            location.y += amount
        case "S":
            location.y -= amount
        case "E":
            location.x += amount
        case "W":
            location.x -= amount
        case "L":
            direction = direction - amount
            if direction < 0 { direction += 360 }
        case "R":
            direction = direction + amount
            if direction >= 360 { direction -= 360 }
        case "F":
            switch direction {
            case 0: location.y += amount
            case 90: location.x += amount
            case 180: location.y -= amount
            case 270: location.x -= amount
            default: fatalError("illegal direction")
            }
        default:
            fatalError("unknown command \(line)")
        }
    }

    return location.distance(from: .origin)
}

extension Int {
    var sign: Int {
        if self < 0 {
            return -1
        } else if self > 0 {
            return 1
        } else {
            return 0
        }
    }
}

extension Point {
    func rotated(_ degrees: Int) -> Point {
        precondition(degrees % 90 == 0)
        precondition(degrees >= 0)
        precondition(degrees < 360)
        switch degrees {
        case 0:
            return self
        case 90:
            switch (x.sign, y.sign) {
            case (0, _): return Point(x: -y, y: 0)
            case (_, 0): return Point(x: 0, y: -x)
            default: return Point(x: y, y: -x)
            }
        case 180:
            return Point(x: -self.x, y: -self.y)
        case 270:
            return self.rotated(180).rotated(90)
        default: fatalError("illegal direction")
        }
    }
}

func navigate2(input: [String]) -> Int {
    var location = Point(x: 0, y: 0) // y axis points north
    var waypoint = Point(x: 10, y: 1)

    for line in input {
        let command = line.first!
        let amount = Int(line.dropFirst())!

        print("line \(line) location \(location) waypoint \(waypoint)")
        switch command {
        case "N":
            waypoint.y += amount
        case "S":
            waypoint.y -= amount
        case "E":
            waypoint.x += amount
        case "W":
            waypoint.x -= amount
        case "L":
            let direction = (-amount) + 360
            waypoint = waypoint.rotated(direction)
        case "R":
            waypoint = waypoint.rotated(amount)
        case "F":
            let xDelta = waypoint.x * amount
            let yDelta = waypoint.y * amount
            location = location + Point(x: xDelta, y: yDelta)
        default:
            fatalError("unknown command \(line)")
        }
    }

    return location.distance(from: .origin)
}
