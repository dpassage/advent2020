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
default:
    print("Unknown command")
    exit(1)
}
