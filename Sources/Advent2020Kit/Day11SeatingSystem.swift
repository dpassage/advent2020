//
//  File.swift
//  
//
//  Created by David Paschich on 12/11/20.
//

import Foundation
import AdventLib

// 2441 was correct!
public func day11part1() {
    let lines = readLines()
    let input = lines.joined(separator: "\n")
    let result = fillSeats(input: input, iterate: iterate(rect:))
    print(result)
}

// 2190 was correct!
public func day11part2() {
    let lines = readLines()
    let input = lines.joined(separator: "\n")
    let result = fillSeats(input: input, iterate: iterate2(rect:))
    print(result)
}

enum SeatCell: Character, Equatable {
    case floor = "."
    case empty = "L"
    case occupied = "#"

    var hasPerson: Bool {
        return self == .occupied
    }
}

func fillSeats(input: String, iterate: (Rect<SeatCell>) -> Rect<SeatCell>) -> Int {
    guard var layout = Rect<SeatCell>(pattern: input) else {
        return -1
    }

    while true {
        let nextLayout = iterate(layout)
        if layout == nextLayout {
            break
        } else {
            layout = nextLayout
        }
    }

    return layout.reduce(0) { (sum, seat) -> Int in
        return sum + (seat.hasPerson ? 1 : 0)
    }
}

func iterate(rect: Rect<SeatCell>) -> Rect<SeatCell> {
    var result = rect

    for row in 0..<rect.height {
        for column in 0..<rect.width {
            let point = Point(x: column, y: row)
            let thisSeat = rect[point]
            guard thisSeat != .floor else { continue }
            let allAdjacents = point.allAdjacents()
            let count = allAdjacents.filter { rect.isValidIndex($0) }.map { rect[$0] }.filter { $0.hasPerson }.count
            if thisSeat == .empty && count == 0 {
                result[point] = .occupied
            }
            if thisSeat == .occupied && count >= 4 {
                result[point] = .empty
            }
        }
    }

    return result
}

func iterate2(rect: Rect<SeatCell>) -> Rect<SeatCell> {
    var result = rect

    for row in 0..<rect.height {
        for column in 0..<rect.width {
            let point = Point(x: column, y: row)
            let thisSeat = rect[point]
            guard thisSeat != .floor else { continue }

            let allAdjacents = point.allAdjacents().filter { rect.isValidIndex($0) }

            var occupiedSeats = 0
            nextAdj: for var adjacent in allAdjacents {
                let delta = adjacent - point
                while rect.isValidIndex(adjacent) {
                    switch rect[adjacent] {
                    case .empty: continue nextAdj
                    case .occupied:
                        occupiedSeats += 1
                        continue nextAdj
                    case .floor:
                        break
                    }
                    adjacent = adjacent + delta
                }
            }
            if thisSeat == .empty && occupiedSeats == 0 {
                result[point] = .occupied
            }
            if thisSeat == .occupied && occupiedSeats >= 5 {
                result[point] = .empty
            }
        }
    }

    return result
}
