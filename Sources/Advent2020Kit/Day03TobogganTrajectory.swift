//
//  Day03TobogganTrajectory.swift
//
//
//  Created by David Paschich on 12/3/20.
//

import Foundation
import AdventLib

// 268 was correct!
public func day03part1() {
    let inputs = readLines()
    let map = TobogganMap(lines: inputs)
    let trees = map.traverse(right: 3, down: 1)
    print(trees)
}

// 3093068400 was correct!
public func day03part2() {
    let inputs = readLines()
    let map = TobogganMap(lines: inputs)
    let trees = map.traverseMany()
    print(trees)
}

struct TobogganMap {
    var grid: Rect<Bool>

    init(lines: [String]) {
        let width = lines[0].count
        let height = lines.count

        grid = Rect(width: width, height: height, defaultValue: false)
        for (row, line) in lines.enumerated() {
            for (column, char) in line.enumerated() {
                switch char {
                case ".": grid[column, row] = false
                case "#": grid[column, row] = true
                default: fatalError("unexpected character")
                }
            }
        }
    }

    // traverse the map with the given slope, counting the trees.
    func traverse(right: Int, down: Int) -> Int {
        var current = Point(x: right, y: down)
        var trees = 0
        while current.y < grid.height {
            if grid[current] { trees += 1}
            current.x = (current.x + right) % grid.width
            current.y += down
        }
        return trees
    }

    func traverseMany() -> Int {
        /*
         Right 1, down 1.
         Right 3, down 1. (This is the slope you already checked.)
         Right 5, down 1.
         Right 7, down 1.
         Right 1, down 2.
         */

        let slopes: [(Int, Int)] = [
            (1, 1),
            (3, 1),
            (5, 1),
            (7, 1),
            (1, 2)
        ]

        let trees = slopes.map(traverse)
        let result = trees.reduce(1, *)
        return result
    }
}
