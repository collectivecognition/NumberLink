//
//  GameScene.swift
//  NumberLink
//
//  Created by Will Blanchette on 2015-01-10.
//  Copyright (c) 2015 Collective Cognition. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    required init(coder aCoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let grid: [[GridTypes]] = [
            [.Obstacle, .Empty, .Obstacle],
            [.Empty, .Obstacle, .Empty],
            [.Obstacle, .Empty, .Obstacle]
        ]
        
        let puzzle: Puzzle = Puzzle(grid: grid)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
