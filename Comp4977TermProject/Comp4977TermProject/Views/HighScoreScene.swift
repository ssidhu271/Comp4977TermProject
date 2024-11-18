//
//  HighScore.swift
//  Comp4977TermProject
//
//  Created by Sukhraj Sidhu on 2024-11-18.
//

import SpriteKit

class HighScoreScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        
        let titleLabel = SKLabelNode(fontNamed: "Arial")
        titleLabel.text = "High Scores"
        titleLabel.fontSize = 50
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height - 100)
        addChild(titleLabel)
        
        let highScores = HighScoreManager.shared.fetchHighScores()
                for (index, highScore) in highScores.enumerated() {
                    let playerName = highScore.name ?? "Unknown" // Safely unwrap or provide a default value
                    let label = SKLabelNode(fontNamed: "Arial")
                    label.text = "\(index + 1). \(playerName): \(highScore.score)"
                    label.fontSize = 30
                    label.fontColor = .white
                    label.position = CGPoint(x: frame.midX, y: frame.height - CGFloat(150 + index * 40))
                    addChild(label)
                }
        
        let backButton = SKLabelNode(fontNamed: "Arial")
        backButton.text = "Back"
        backButton.fontSize = 40
        backButton.fontColor = .red
        backButton.position = CGPoint(x: frame.midX, y: 50)
        backButton.name = "backButton"
        addChild(backButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        if touchedNode.name == "backButton" {
            let mainMenu = MainMenuScene(size: self.size)
            mainMenu.scaleMode = .aspectFill
            self.view?.presentScene(mainMenu, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
