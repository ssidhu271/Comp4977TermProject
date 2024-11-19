//
//  Obstacle.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    private var walkTextures: [SKTexture] = []

    init() {
        // Load the skeleton walk textures
        let atlas = SKTextureAtlas(named: "Skel_walk")
        for i in 1...6 { // Assuming 6 frames for walking animation
            let textureName = "walk_\(i)"
            walkTextures.append(atlas.textureNamed(textureName))
        }

        // Initialize with the first frame of the skeleton walk animation
        let initialTexture = walkTextures[0]
        let size = initialTexture.size()

        super.init(texture: initialTexture, color: .clear, size: size)
        self.name = "obstacle"
        
        // Scale the sprite to make it visually larger
        self.setScale(2.0) // Double the size of the sprite
        
        // Flip the sprite to face left
        self.xScale = -2.0 // Horizontal flip while maintaining scale
        
        // Physics Body
        // Set a smaller, more accurate physics body
        let hitboxSize = CGSize(width: self.size.width * 0.3, height: self.size.height * 0.5) // Scale down the hitbox
        self.physicsBody = SKPhysicsBody(rectangleOf: hitboxSize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.character
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        // Start the walking animation
        startWalkingAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Start the skeleton walking animation
    func startWalkingAnimation() {
        let walkAnimation = SKAction.animate(with: walkTextures, timePerFrame: 0.1)
        let repeatAnimation = SKAction.repeatForever(walkAnimation)
        self.run(repeatAnimation, withKey: "walking")
    }

    // Start moving the obstacle across the screen
    func startMoving(duration: TimeInterval) {
        let moveAction = SKAction.moveBy(x: -UIScreen.main.bounds.width - self.size.width, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        self.run(SKAction.sequence([moveAction, removeAction]))
    }
}

