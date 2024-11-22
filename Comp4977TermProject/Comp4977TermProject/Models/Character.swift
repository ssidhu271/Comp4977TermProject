//
//  Character.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Character: SKSpriteNode {

    // Property to hold animation textures
    private var runTextures: [SKTexture] = []
    private var canJump = true
    
    init() {
        // Load the texture atlas
        let running = SKTextureAtlas(named: "Sprites")
    
        // Load the running animation frames
        for i in 1...8 {
            let textureName = "tile_\(i)"
            runTextures.append(running.textureNamed(textureName))
        }
           
        // Initialize with the first texture
        let initialTexture = runTextures[0]
        let size = initialTexture.size() // Adjust size to match the sprite
        
        super.init(texture: initialTexture, color: .clear, size: size)
        
        self.zPosition = 20
        self.xScale = 2.0 // Double the width
        self.yScale = 2.0 // Double the height
        
        self.name = "character"
        
        // Configure the physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width * 0.5, height: size.height * 0.8), center: CGPoint(x: 0, y: -size.height * 0.1))
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
    
    // Method to start the running animation
    func startRunningAnimation() {
        let runAnimation = SKAction.animate(with: runTextures, timePerFrame: 0.1)
        let repeatAnimation = SKAction.repeatForever(runAnimation)
        self.run(repeatAnimation)
    }
    
    // Perform the jump animation
    func jump() {
        guard canJump else { return } // Prevent jumping if already in the air

        canJump = false // Disable jumping until landing

        // Apply jump physics
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))

        // Play the jump animation
        let jumpAnimation = SKAction.animate(with: runTextures, timePerFrame: 0.16)
        let completion = SKAction.run { [weak self] in
            self?.startRunningAnimation() // Restart running animation
        }
        let jumpSequence = SKAction.sequence([jumpAnimation, completion])
        self.run(jumpSequence, withKey: "walking")
    }
    
    func onLand() {
        canJump = true // Allow jumping again
    }

}

