//
//  Puzzle.swift
//  NumberLink
//
//  Created by Will Blanchette on 2015-01-10.
//  Copyright (c) 2015 Collective Cognition. All rights reserved.
//

import SpriteKit

enum GridTypes {
    case Empty
    case Obstacle
    case Terminal(Int)
    case HorizontalLine(Int)
    case VerticalLine(Int)
}

struct GridSize {
    var width: Int
    var height: Int
}

class Puzzle {
    var grid: [[GridTypes]]
    var colors: [SKColor]

    init (grid: [[GridTypes]], colors: [SKColor]) {
        self.grid = grid
        self.colors = colors
    }
    
    var size: GridSize {
        get {
            return GridSize(width: grid[0].count, height: grid.count)
        }
    }
}
