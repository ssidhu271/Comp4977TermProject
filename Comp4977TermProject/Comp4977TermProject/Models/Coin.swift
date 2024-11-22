//
//  Coin.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class Coin: SKSpriteNode {
    private var coinTextures: [SKTexture] = []
    
    init() {
        // Load the sprite sheet
        let spriteSheet = SKTexture(imageNamed: "coin4_16x16") // Replace with your file name
        let frameSize = CGSize(width: 16, height: 16) // Frame dimensions in pixels
        let textureWidth = frameSize.width / spriteSheet.size().width
        let textureHeight = frameSize.height / spriteSheet.size().height
        
        // Extract individual frames
        for i in 0..<6 { // Assuming 6 frames
            let rect = CGRect(x: CGFloat(i) * textureWidth, y: 0, width: textureWidth, height: textureHeight)
            coinTextures.append(SKTexture(rect: rect, in: spriteSheet))
        }
        
        // Initialize with the first frame
        super.init(texture: coinTextures[0], color: .clear, size: frameSize)
        self.name = "coin"
        
        self.zPosition = 18

        self.xScale = 1.5
        self.yScale = 1.5
        
        // Set up the physics body
        self.physicsBody = SKPhysicsBody(circleOfRadius: frameSize.width / 2)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.character
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        // Start spinning animation
        startSpinning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startSpinning() {
        let spinAction = SKAction.animate(with: coinTextures, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(spinAction), withKey: "spinning")
    }
    
    func startMoving(duration: TimeInterval) {
        let moveAction = SKAction.moveBy(x: -UIScreen.main.bounds.width - self.size.width, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        self.run(SKAction.sequence([moveAction, removeAction]))
    }
}



