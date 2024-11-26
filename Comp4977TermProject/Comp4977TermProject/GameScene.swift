import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var character: Character!
    private var ground: Ground!
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
        character.startRunningAnimation()
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
    
    
    
    private var currentObstacleDelay: TimeInterval = 5.0 // Start with 5 seconds delay
    private var lastSpawnedObstacle: SKSpriteNode? = nil // Track the last spawned obstacle
    private let minimumObstacleSpacing: CGFloat = 200 // Minimum horizontal spacing

    private func scheduleSpawning() {
        // Spawn obstacles
        let spawnObstacleAction = SKAction.run { [weak self] in
            guard let self = self else { return }

            // Use the random obstacle creation method
            let obstacle = self.createRandomObstacle()

            // Calculate the new obstacle's position
            let newObstaclePositionX = self.frame.width + obstacle.size.width / 2
            let newObstaclePositionY = self.ground.size.height + (obstacle.size.height / 2) - 25

            // Check spacing with the last spawned obstacle
            if let lastObstacle = self.lastSpawnedObstacle {
                let lastObstacleX = lastObstacle.position.x
                if abs(newObstaclePositionX - lastObstacleX) < self.minimumObstacleSpacing {
                    print("Skipped spawning to maintain minimum spacing.")
                    return // Skip spawning if too close to the last one
                }
            }

            // Set the new obstacle's position
            obstacle.position = CGPoint(x: newObstaclePositionX, y: newObstaclePositionY)
            self.addChild(obstacle)

            // Update the lastSpawnedObstacle reference
            self.lastSpawnedObstacle = obstacle

            // Start moving the obstacle
            if let movingObstacle = obstacle as? Obstacle {
                movingObstacle.startMoving(duration: 3.0)
            } else if let movingObstacle = obstacle as? Obstacle2 {
                movingObstacle.startMoving(duration: 3.0)
            } else if let movingObstacle = obstacle as? Obstacle3 {
                movingObstacle.startMoving(duration: 3.0)
            }
        }

        // Recursive function to handle dynamic delay
        func startSpawning() {
            let spawnSequence = SKAction.sequence([
                spawnObstacleAction,
                SKAction.wait(forDuration: currentObstacleDelay)
            ])
            run(SKAction.repeatForever(spawnSequence), withKey: "obstacleSpawning")
        }

        // Start the initial spawning sequence
        startSpawning()

        // Schedule dynamic adjustment of delay
        let adjustDelayAction = SKAction.run { [weak self] in
            guard let self = self else { return }
            if self.currentObstacleDelay > 1.0 { // Limit to a minimum delay of 1 second
                self.currentObstacleDelay -= 0.5
                print("New obstacle delay: \(self.currentObstacleDelay)")

                // Restart the spawning sequence with the new delay
                self.removeAction(forKey: "obstacleSpawning")
                startSpawning()
            }
        }

        // Adjust delay every 30 seconds
        let adjustDelayInterval = SKAction.wait(forDuration: 30.0)
        let adjustDelayLoop = SKAction.repeatForever(SKAction.sequence([adjustDelayAction, adjustDelayInterval]))
        run(adjustDelayLoop, withKey: "adjustDelay")
    
    

        
        func randomCoinDelay() -> TimeInterval {
            return TimeInterval.random(in: 1.0...6.0) // Random delay
        }

        let spawnCoinAction = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            let coin = Coin()
            coin.position = CGPoint(
                x: self.frame.width + coin.size.width / 2,
                y: self.ground.size.height + coin.size.height + 60
            )
            self.addChild(coin)
            coin.startMoving(duration: 4.0)
        }

        // Recursive function for random coin spawning
        func startSpawningCoins() {
            let randomDelay = randomCoinDelay()
            let coinSequence = SKAction.sequence([
                spawnCoinAction,
                SKAction.wait(forDuration: randomDelay) // Wait for a random delay
            ])
            self.run(SKAction.sequence([coinSequence, SKAction.run(startSpawningCoins)]), withKey: "coinSpawning")
        }

        // Start the recursive coin spawning
        startSpawningCoins()

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
        guard !isGameOver else {
            return
        }
        character.jump()
    }

    private func gameOver() {
        isGameOver = true

        let gameOverScene = GameOverScene(size: self.size, finalScore: scoreManager.getScore())
        gameOverScene.scaleMode = .aspectFill
        self.view?.presentScene(gameOverScene, transition: SKTransition.fade(withDuration: 1.0))
    }
}
