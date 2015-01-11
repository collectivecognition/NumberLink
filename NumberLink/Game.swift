//
//  Game.swift
//  NumberLink
//
//  Created by Will Blanchette on 2015-01-10.
//  Copyright (c) 2015 Collective Cognition. All rights reserved.
//

private let _GameSharedInstance = Game()

class Game {
    var puzzle: Puzzle
    
    init () {
        let grid: [[GridTypes]] = [
            [.Obstacle, .Empty, .Obstacle],
            [.Empty, .Obstacle, .Empty],
            [.Obstacle, .Empty, .Obstacle]
        ]
        
        puzzle = Puzzle(grid: grid)
    }
    
    class var shared: Game {
        return _GameSharedInstance
    }
}