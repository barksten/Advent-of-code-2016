//: Playground - noun: a place where people can play

import Cocoa

let input = "L1, R3, R1, L5, L2, L5, R4, L2, R2, R2, L2, R1, L5, R3, L4, L1, L2, R3, R5, L2, R5, L1, R2, L5, R4, R2, R2, L1, L1, R1, L3, L1, R1, L3, R5, R3, R3, L4, R4, L2, L4, R1, R1, L193, R2, L1, R54, R1, L1, R71, L4, R3, R191, R3, R2, L4, R3, R2, L2, L4, L5, R4, R1, L2, L2, L3, L2, L1, R4, R1, R5, R3, L5, R3, R4, L2, R3, L1, L3, L3, L5, L1, L3, L3, L1, R3, L3, L2, R1, L3, L1, R5, R4, R3, R2, R3, L1, L2, R4, L3, R1, L1, L1, R5, R2, R4, R5, L1, L1, R1, L2, L4, R3, L1, L3, R5, R4, R3, R3, L2, R2, L1, R4, R2, L3, L4, L2, R2, R2, L4, R3, R5, L2, R2, R4, R5, L2, L3, L2, R5, L4, L2, R3, L5, R2, L1, R1, R3, R3, L5, L2, L2, R5"

let steps = input.components(separatedBy: ", ")

struct Coord {
    let x: Int
    let y: Int
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Turn: Character {
    case Left = "L"
    case Right = "R"
}

struct Pos {
    let heading: CompassPoint
    let coord: Coord
}

func move(pos: Pos, by input: ArraySlice<String>) -> Pos {
    guard let head: String = input.first else {
        print("Slut på element!")
        return pos
    }
    guard let numberOfSteps = Int(String(head.dropFirst())) else {
        print("Inga steg!")
        return pos
    }
    guard let turn: Turn = Turn(rawValue: head.first!) else {
        print("Not allowed: \(head.first!)! ")
        return pos
    }
    
    let tail = input.dropFirst()
    
    switch (pos.heading, turn) {
        
    case (.north, .Left):
        let newPos = Pos(heading: CompassPoint.west,
                         coord:  Coord(x: pos.coord.x - numberOfSteps, y: pos.coord.y))
        return move(pos: newPos, by: tail)
        
    case (.north, .Right):
        let newPos = Pos(heading: CompassPoint.east,
                         coord:  Coord(x: pos.coord.x + numberOfSteps, y: pos.coord.y))
        return move(pos: newPos, by: tail)
        
    case (.east, .Left):
        let newPos = Pos(heading: CompassPoint.north,
                         coord:  Coord(x: pos.coord.x, y: pos.coord.y + numberOfSteps))
        return move(pos: newPos, by: tail)
        
    case (.east, .Right):
        let newPos = Pos(heading: CompassPoint.south,
                         coord:  Coord(x: pos.coord.x, y: pos.coord.y - numberOfSteps))
        return move(pos: newPos, by: tail)
        
    case (.south, .Left):
        let newPos = Pos(heading: CompassPoint.east,
                         coord:  Coord(x: pos.coord.x + numberOfSteps, y: pos.coord.y))
        return move(pos: newPos, by: tail)
        
    case (.south, .Right):
        let newPos = Pos(heading: CompassPoint.west,
                         coord:  Coord(x: pos.coord.x - numberOfSteps, y: pos.coord.y))
        return move(pos: newPos, by: tail)
        
    case (.west, .Left):
        let newPos = Pos(heading: CompassPoint.south,
                         coord:  Coord(x: pos.coord.x, y: pos.coord.y - numberOfSteps))
        return move(pos: newPos, by: tail)
    case (.west, .Right):
        let newPos = Pos(heading: CompassPoint.north,
                         coord:  Coord(x: pos.coord.x, y: pos.coord.y + numberOfSteps))
        return move(pos: newPos, by: tail)
    }
}

func distance(start: Coord, stop: Coord) -> Int {
    return (abs(start.x + stop.x) + abs(start.y + stop.y) )
}

let pos = Pos(heading: CompassPoint.north, coord: Coord(x: 0, y: 0))
print(pos)

let moved = move(pos: pos, by: steps.suffix(from: 0))
print(moved)

let dist = distance(start: pos.coord, stop: moved.coord)

print(dist)

