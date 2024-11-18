//
//  Character.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Character: SKSpriteNode {
    init() {
        let size = CGSize(width: 50, height: 50)
        super.init(texture: nil, color: .red, size: size) // Use a texture for the character if available
        self.name = "character"

        // Physics Body
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.character
        self.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle | PhysicsCategory.ground | PhysicsCategory.coin
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func jump() {
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 70)) // Adjust jump strength
    }
}

