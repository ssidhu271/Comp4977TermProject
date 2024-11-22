import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var character: Character!
    private var ground: Ground!
    private var jumpButton: JumpButton!
    private var scoreManager: ScoreManager!
    private var isGameOver = false

    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self

        self.backgroundColor = .white

        // Enable hitbox debugging
        if let skView = self.view {
            skView.showsPhysics = true
        }

        // Add the background
        addGameBackground()

        // Add the ground
        ground = Ground(frame: frame)
        ground.zPosition = 5 // Ensure it's above the background
        addChild(ground)

        // Add the character
        addCharacter()

        // Add the jump button
        jumpButton = JumpButton()
        jumpButton.position = CGPoint(x: frame.midX, y: frame.minY + 250)
        jumpButton.zPosition = 15
        jumpButton.name = "jumpButton" // Make it interactable
        addChild(jumpButton)

        // Add the score label
        scoreManager = ScoreManager(frame: frame)
        addChild(scoreManager.getScoreLabel())

        // Start spawning obstacles and coins
        scheduleSpawning()
        
        
    }

    private func addGameBackground() {
        let background = GameBackground()
        background.position = CGPoint.zero // Align with the screen
        background.zPosition = -1 // Ensure it's behind everything else
        addChild(background)
    }

    private func addCharacter() {
        character = Character()
        let xPosition = frame.minX + 40
        let yPosition = ground.position.y + ground.size.height / 2 + character.size.height / 2
        character.position = CGPoint(x: xPosition, y: yPosition)
        addChild(character)
        character.startWalkingAnimation()
    }

    private func createRandomObstacle() -> SKSpriteNode {
        let obstacleTypes: [() -> SKSpriteNode] = [
            { Obstacle() },   // Skeleton
            { Obstacle2() },  // Slime
            { Obstacle3() }   // Fat plant
        ]

        let randomIndex = Int.random(in: 0..<obstacleTypes.count) // Randomly pick one
        return obstacleTypes[randomIndex]()
    }
    
    
    private func scheduleSpawning() {

        let spawnObstacleAction = SKAction.run { [weak self] in
            guard let self = self else { return }

            // Use the random obstacle creation method
            let obstacle = self.createRandomObstacle()
            obstacle.position = CGPoint(
                x: self.frame.width + obstacle.size.width / 2, // Start offscreen on the right
                y: self.ground.size.height + (obstacle.size.height / 2) - 25 // Align with the ground
            )
            self.addChild(obstacle)

            // Ensure `startMoving` works for all obstacle types
            if let movingObstacle = obstacle as? Obstacle {
                movingObstacle.startMoving(duration: 3.0)
            } else if let movingObstacle = obstacle as? Obstacle2 {
                movingObstacle.startMoving(duration: 3.0)
            } else if let movingObstacle = obstacle as? Obstacle3 {
                movingObstacle.startMoving(duration: 3.0)
            }
        }

        //@@@@@@@@@@@@ this what you need to change to make the game harder@@@@@@@@@@@@
        let obstacleDelay = SKAction.wait(forDuration: 4)
        run(SKAction.repeatForever(SKAction.sequence([spawnObstacleAction, obstacleDelay])))

      

        let spawnCoinAction = SKAction.run { [weak self] in
            let coin = Coin()
            coin.position = CGPoint(x: self!.frame.width + coin.size.width / 2,
                                     y: self!.ground.size.height + coin.size.height + 60)
            self?.addChild(coin)
            coin.startMoving(duration: 4.0)
        }
        let coinDelay = SKAction.wait(forDuration: 3.0)
        run(SKAction.repeatForever(SKAction.sequence([spawnCoinAction, coinDelay])))
    }
                                     

    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA.categoryBitMask
        let contactB = contact.bodyB.categoryBitMask

        if (contactA == PhysicsCategory.character && contactB == PhysicsCategory.obstacle) ||
            (contactA == PhysicsCategory.obstacle && contactB == PhysicsCategory.character) {
            gameOver()
        }

        if (contactA == PhysicsCategory.character && contactB == PhysicsCategory.coin) ||
            (contactA == PhysicsCategory.coin && contactB == PhysicsCategory.character) {
            scoreManager.incrementScore()

            if contact.bodyA.node?.name == "coin" {
                contact.bodyA.node?.removeFromParent()
            } else if contact.bodyB.node?.name == "coin" {
                contact.bodyB.node?.removeFromParent()
            }
        }
        
        // Check for Character-Ground collision
        if (contactA == PhysicsCategory.character && contactB == PhysicsCategory.ground) ||
            (contactA == PhysicsCategory.ground && contactB == PhysicsCategory.character) {
            if let character = contact.bodyA.node as? Character ?? contact.bodyB.node as? Character {
                character.onLand()
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if !isGameOver, touchedNode.name == "jumpButton" {
            character.jump()
        }
    }

    private func gameOver() {
        isGameOver = true

        let gameOverScene = GameOverScene(size: self.size, finalScore: scoreManager.getScore())
        gameOverScene.scaleMode = .aspectFill
        self.view?.presentScene(gameOverScene, transition: SKTransition.fade(withDuration: 1.0))
    }
}
