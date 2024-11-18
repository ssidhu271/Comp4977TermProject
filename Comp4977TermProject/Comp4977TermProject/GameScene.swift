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

        ground = Ground(frame: frame)
        addChild(ground)

        addCharacter()

        jumpButton = JumpButton()
        addChild(jumpButton)

        scoreManager = ScoreManager(frame: frame)
        addChild(scoreManager.getScoreLabel())

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

        if !isGameOver, touchedNode.name == "jumpButton" {
            character.jump()
        }
    }

    private func gameOver() {
        isGameOver = true

        // Transition to GameOverScene with the final score
        let gameOverScene = GameOverScene(size: self.size, finalScore: scoreManager.getScore())
        gameOverScene.scaleMode = .aspectFill
        self.view?.presentScene(gameOverScene, transition: SKTransition.fade(withDuration: 1.0))
    }
}
