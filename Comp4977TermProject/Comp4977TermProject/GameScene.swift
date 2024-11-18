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

        // Add ground
        ground = Ground(frame: frame)
        addChild(ground)

        // Add character
        addCharacter()

        // Add jump button
        jumpButton = JumpButton()
        addChild(jumpButton)

        // Add score manager
        scoreManager = ScoreManager(frame: frame)
        addChild(scoreManager.getScoreLabel())

        // Schedule spawning
        scheduleSpawning()
    }

    private func addCharacter() {
        character = Character()
        character.position = CGPoint(x: frame.midX / 2, y: ground.size.height + character.size.height / 2)
        addChild(character)
    }

    private func scheduleSpawning() {
        let spawnObstacleAction = SKAction.run { [weak self] in
            let obstacle = Obstacle()
            obstacle.position = CGPoint(x: self!.frame.width + obstacle.size.width / 2,
                                        y: self!.ground.size.height + obstacle.size.height / 2)
            self?.addChild(obstacle)
            obstacle.startMoving(duration: 4.0)
        }
        let obstacleDelay = SKAction.wait(forDuration: 2.0)
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
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if isGameOver {
            if touchedNode.name == "restartButton" {
                let newScene = GameScene(size: size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene, transition: .fade(withDuration: 1.0))
            }
        } else if touchedNode.name == "jumpButton" {
            character.jump()
        }
    }

    private func gameOver() {
        isGameOver = true

        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        addChild(gameOverLabel)

        let restartButton = SKLabelNode(fontNamed: "Arial")
        restartButton.text = "Restart"
        restartButton.fontSize = 40
        restartButton.fontColor = .blue
        restartButton.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        restartButton.name = "restartButton"
        addChild(restartButton)
    }
}
