//
//  Ground.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Ground: SKSpriteNode {
    init(frame: CGRect) {
        let size = CGSize(width: frame.width, height: 50)
        super.init(texture: nil, color: .black, size: size)
        self.name = "ground"
        self.position = CGPoint(x: frame.midX, y: size.height / 2)
        
        // Physics Body
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground
        self.physicsBody?.collisionBitMask = PhysicsCategory.character
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

