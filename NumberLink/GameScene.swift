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
    let startPosition = CGPoint(x: 0.0, y: 0.0)
    let nodeSize = CGSize(width: 0.0, height: 0.0)
    
    var isDrawingLine = false
    var currentLineColor: Int = 0
    
    var nodes: [[SKShapeNode]] = [[SKShapeNode()]]
    
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

        nodeSize = CGSizeMake(tileSize, tileSize)
        
        // nodes = Array(count: Game.shared.puzzle.size.width, repeatedValue: Array(count: Game.shared.puzzle.size.height, repeatedValue: SKShapeNode(rectOfSize: nodeSize)))
        
        for var i = 0; i < Game.shared.puzzle.size.height; i++ {
            nodes.append([SKShapeNode]())
            
            for var j = 0; j < Game.shared.puzzle.size.width; j++ {
                
                var node = SKShapeNode(rectOfSize: nodeSize)
                
                node.position = CGPoint(
                    x: startPosition.x + tileSize * CGFloat(j),
                    y: startPosition.y + tileSize * CGFloat(Game.shared.puzzle.size.height - i)
                )
                
                let gridCell = Game.shared.puzzle.grid[i][j]
                
                switch(gridCell) {
                    case .Obstacle:
                        node.fillColor = SKColor.whiteColor()
                    
                    case .Terminal(let color):
                        node.fillColor = Game.shared.puzzle.colors[color]
                    
                    default:
                        node.fillColor = SKColor.blackColor()
                }
                
                self.addChild(node)
                nodes[i].append(node)
            }
        }
    }
    
    func locationToGridIndexes(location: CGPoint) -> [Int] {
        let x = Int(floor((location.x - startPosition.x + tileSize / 2) / tileSize))
        let y = Game.shared.puzzle.size.height - Int(floor((location.y - startPosition.y + tileSize / 2) / tileSize))
        return [x, y]
    }
    
    func locationToGridCell(location: CGPoint) -> (GridTypes) {
        var gridIndexes = locationToGridIndexes(location)
        return Game.shared.puzzle.grid[gridIndexes[1]][gridIndexes[0]]
    }
    
    override func update(currentTime: CFTimeInterval) {
        for var i = 0; i < Game.shared.puzzle.size.height; i++ {
            for var j = 0; j < Game.shared.puzzle.size.width; j++ {
                let node = nodes[i][j]
                let gridCell = Game.shared.puzzle.grid[i][j]
                
                switch gridCell {
                    case .Terminal(let color):
                        node.fillColor = Game.shared.puzzle.colors[color]
                    default: ()
                }
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let gridCell = locationToGridCell(location)
            
            switch(gridCell) {
                case .Terminal(let color):
                    currentLineColor = color
                    isDrawingLine = true
                default: ()
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if(isDrawingLine) {
            for touch in touches {
                let location = touch.locationInNode(self)
                let gridIndexes = locationToGridIndexes(location)
                let gridCell = locationToGridCell(location)
                
                switch(gridCell) {
                    case .Empty:
                        Game.shared.puzzle.grid[gridIndexes[1]][gridIndexes[0]] = GridTypes.Terminal(currentLineColor)
                    default: ()
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            isDrawingLine = false
        }
    }
}
