//
//  Obstacle3.swift
//  Comp4977TermProject
//
//  Created by Parin Ravanbakhsh on 2024-11-21.
//

import SpriteKit

class Obstacle3: SKSpriteNode {
    private var obstacleTextures: [SKTexture] = []

    init() {
        let spriteSheet = SKTexture(imageNamed: "fat_plant_sprite_sheet")
        obstacleTextures = extractFrames(from: spriteSheet, row: 1, columns: 5, totalRows: 4)

        let initialTexture = obstacleTextures[0]
        let size = CGSize(width: 32, height: 32)

        super.init(texture: initialTexture, color: .clear, size: size)
        self.name = "obstacle3"
        
        self.xScale = -2 // Adjust to make the obstacle wider (default is 1.0)
        self.yScale = 2 // Adjust to make the obstacle taller (default is 1.0)

        self.zPosition = 18

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width * 0.5, height: size.height * 0.8), center: CGPoint(x: 0, y: -size.height * 0.1))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.character
        self.physicsBody?.collisionBitMask = PhysicsCategory.none

        startAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func startAnimation() {
        let animation = SKAction.animate(with: obstacleTextures, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(animation), withKey: "obstacle3Animation")
    }

    func startMoving(duration: TimeInterval) {
        let moveAction = SKAction.moveBy(x: -UIScreen.main.bounds.width - self.size.width, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        self.run(SKAction.sequence([moveAction, removeAction]))
    }
}
