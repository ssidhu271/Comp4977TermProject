//
//  GameOverScene.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-18.
//

import SpriteKit

class GameOverScene: SKScene {
    private var finalScore: Int = 0 // Property to store the final score

    init(size: CGSize, finalScore: Int) {
        self.finalScore = finalScore
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .black

        // Add "Game Over" label
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(gameOverLabel)

        // Add "Final Score" label
        let scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = "Final Score: \(finalScore)"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(scoreLabel)

        // Add "Restart" button
        let restartButton = SKLabelNode(fontNamed: "Arial")
        restartButton.text = "Restart"
        restartButton.fontSize = 40
        restartButton.fontColor = .blue
        restartButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        restartButton.name = "restartButton"
        addChild(restartButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if touchedNode.name == "restartButton" {
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}

