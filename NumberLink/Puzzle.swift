//
//  Puzzle.swift
//  NumberLink
//
//  Created by Will Blanchette on 2015-01-10.
//  Copyright (c) 2015 Collective Cognition. All rights reserved.
//

enum GridTypes {
    case Empty, Obstacle
}

struct GridSize {
    var width: Int
    var height: Int
}

class Puzzle {
    var grid: [[GridTypes]]

    init (grid: [[GridTypes]]) {
        self.grid = grid
    }
    
    var size: GridSize {
        get {
            return GridSize(width: grid[0].count, height: grid.count)
        }
    }
}
