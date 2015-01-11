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
            [.Obstacle, .Empty, .Obstacle, .Obstacle, .Obstacle, .Empty, .Obstacle, .Obstacle],
            [.Empty, .Obstacle, .Empty, .Obstacle, .Obstacle, .Empty, .Obstacle, .Obstacle],
            [.Obstacle, .Empty, .Obstacle, .Obstacle, .Obstacle, .Empty, .Obstacle, .Obstacle],
            [.Obstacle, .Empty, .Obstacle, .Obstacle, .Obstacle, .Empty, .Obstacle, .Obstacle],
            [.Obstacle, .Empty, .Obstacle, .Obstacle, .Obstacle, .Empty, .Obstacle, .Obstacle],
            [.Obstacle, .Empty, .Obstacle, .Obstacle, .Obstacle, .Empty, .Obstacle, .Obstacle]
        ]
        
        let puzzle: Puzzle = Puzzle(grid: grid)
        
        
        let frameWidth = frame.size.width
        let frameHeight = frame.size.height
        let padding = CGFloat(20.0)
        
        let tileSize = CGFloat(min(
            (frameWidth - (padding * 2)) / CGFloat(puzzle.size.width),
            (frameHeight - (padding * 2)) / CGFloat(puzzle.size.height)))
        
        let startPosition = CGPoint(
            x: frameWidth / 2 - CGFloat(puzzle.size.width) * tileSize / 2 + tileSize / 2,
            y: -frameHeight / 2 + CGFloat(puzzle.size.height) * tileSize / 2 - tileSize / 2
        )

        let nodeSize = CGSizeMake(tileSize, tileSize)

        for var i = 0; i < puzzle.size.height; i++ {
            for var j = 0; j < puzzle.size.width; j++ {
                
                var node = SKShapeNode(rectOfSize: nodeSize)
                node.position = CGPoint(
                    x: startPosition.x + tileSize * CGFloat(j),
                    y: startPosition.y - tileSize * CGFloat(i)
                )
                
                if(puzzle.grid[i][j] == GridTypes.Obstacle) {
                    node.fillColor = SKColor.greenColor()
                }
                else {
                    node.fillColor = SKColor.blueColor()
                }
                
                self.addChild(node)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
