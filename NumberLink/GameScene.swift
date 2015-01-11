//
//  GameScene.swift
//  NumberLink
//
//  Created by Will Blanchette on 2015-01-10.
//  Copyright (c) 2015 Collective Cognition. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let frameWidth: CGFloat = 0, frameHeight: CGFloat = 0
    let padding: CGFloat = 20.0
    let tileSize: CGFloat = 0
    let startPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    required init(coder aCoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 0)
        
        frameWidth = frame.size.width
        frameHeight = frame.size.height
        
        tileSize = CGFloat(min(
            (frameWidth - (padding * 2)) / CGFloat(Game.shared.puzzle.size.width),
            (frameHeight - (padding * 2)) / CGFloat(Game.shared.puzzle.size.height)))
        
        startPosition = CGPoint(
            x: frameWidth / 2 - CGFloat(Game.shared.puzzle.size.width) * tileSize / 2 + tileSize / 2,
            y: frameHeight / 2 - CGFloat(Game.shared.puzzle.size.height) * tileSize / 2 - tileSize / 2
        )

        let nodeSize = CGSizeMake(tileSize, tileSize)
        
        for var i = 0; i < Game.shared.puzzle.size.height; i++ {
            for var j = 0; j < Game.shared.puzzle.size.width; j++ {
                
                var node = SKShapeNode(rectOfSize: nodeSize)
                node.position = CGPoint(
                    x: startPosition.x + tileSize * CGFloat(j),
                    y: startPosition.y + tileSize * CGFloat(Game.shared.puzzle.size.height - i)
                )
                
                let gridCell = Game.shared.puzzle.grid[i][j]
                
                switch(gridCell) {
                case GridTypes.Obstacle:
                        node.fillColor = SKColor.whiteColor()
                    case GridTypes.Terminal(let color):
                        node.fillColor = Game.shared.puzzle.colors[color]
                    default:
                        node.fillColor = SKColor.blackColor()
                }
                
                self.addChild(node)
            }
        }
    }
    
    func locationToGridIndexes(location: CGPoint) -> ([Int]) {
        return []
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            touchedNode.zPosition = 15
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            touchedNode.position = location
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            touchedNode.zPosition = 0
        }
    }
}
