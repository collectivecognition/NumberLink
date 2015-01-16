//
//  Game.swift
//  NumberLink
//
//  Created by Will Blanchette on 2015-01-10.
//  Copyright (c) 2015 Collective Cognition. All rights reserved.
//

import SpriteKit

private let _GameSharedInstance = Game()

class Game {
    var puzzle: Puzzle
    
    init () {
        let grid: [[GridTypes]] = [
            [.Obstacle,     .Terminal(0),   .Empty,         .Empty,         .Terminal(0),   .Obstacle],
            [.Empty,        .Terminal(0),   .Empty,         .Empty,         .Terminal(0),   .Empty],
            [.Empty,        .Empty,         .Terminal(2),   .Empty,         .Terminal(1),   .Empty],
            [.Empty,        .Empty,         .Empty,         .Empty,         .Empty,         .Empty],
            [.Empty,        .Terminal(1),   .Empty,         .Empty,         .Empty,         .Empty],
            [.Obstacle,     .Empty,         .Empty,         .Empty,         .Terminal(2),   .Obstacle]
        ]
        
        let colors = [
            SKColor.redColor(),
            SKColor.blueColor(),
            SKColor.greenColor()
        ]
        
        puzzle = Puzzle(grid: grid, colors: colors)
    }
    
    class var shared: Game {
        return _GameSharedInstance
    }
}