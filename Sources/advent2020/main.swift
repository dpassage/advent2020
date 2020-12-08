import Advent2020Kit
import Darwin

if CommandLine.arguments.count < 2 {
    print("Specify a day")
    exit(1)
}

let command = CommandLine.arguments[1]

switch command {
case "day01part1":
    day01part1()
case "day01part2":
    day01part2()
case "day02part1":
    day02part1()
case "day02part2":
    day02part2()
case "day03part1":
    day03part1()
case "day03part2":
    day03part2()
case "day04part1":
    day04part1()
case "day04part2":
    day04part2()
case "day05part1":
    day05part1()
case "day05part2":
    day05part2()
case "day06part1":
    day06part1()
case "day06part2":
    day06part2()
case "day07part1":
    day07part1()
case "day07part2":
    day07part2()
case "day08part1":
    day08part1()
default:
    print("Unknown command")
    exit(1)
}
