//
//  Coin.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Coin: SKSpriteNode {
    init() {
        let size = CGSize(width: 30, height: 30)
        super.init(texture: nil, color: .yellow, size: size) // Use a coin texture if available
        self.name = "coin"
        
        // Physics Body
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin
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


