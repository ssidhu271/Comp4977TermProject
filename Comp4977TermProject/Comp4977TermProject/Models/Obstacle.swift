//
//  Obstacle.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    init() {
        let size = CGSize(width: 30, height: 30)
        super.init(texture: nil, color: .red, size: size) // Use an obstacle texture if available
        self.name = "obstacle"
        
        // Physics Body
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.character
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startMoving(duration: TimeInterval) {
        let moveAction = SKAction.moveBy(x: -UIScreen.main.bounds.width - self.size.width, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        self.run(SKAction.sequence([moveAction, removeAction]))
    }
}
