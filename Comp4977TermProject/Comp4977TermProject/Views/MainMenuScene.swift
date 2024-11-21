//
//  MainMenuScene.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-16.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Set background color
        self.backgroundColor = .blue
        
        // Add title at the top
        let titleLabel = SKLabelNode(fontNamed: "Arial")
        titleLabel.text = "Forest Runner"
        titleLabel.fontSize = 60
        titleLabel.fontColor = .yellow
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.6)
        addChild(titleLabel)
        
        // Add "Start Game" button
        let startButton = SKLabelNode(fontNamed: "Arial")
        startButton.text = "Start Game"
        startButton.fontSize = 30
        startButton.fontColor = .white
        startButton.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        startButton.name = "startButton" // Assign a name to identify it
        addChild(startButton)
        
        // Add "High Scores" button
        let highScoresButton = SKLabelNode(fontNamed: "Arial")
        highScoresButton.text = "High Scores"
        highScoresButton.fontSize = 30
        highScoresButton.fontColor = .white
        highScoresButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        highScoresButton.name = "highScoresButton" // Assign a name to identify it
        addChild(highScoresButton)
        
        // Add "Credits" button
                let creditsButton = SKLabelNode(fontNamed: "Arial")
                creditsButton.text = "Credits"
                creditsButton.fontSize = 30
                creditsButton.fontColor = .white
                creditsButton.position = CGPoint(x: frame.midX, y: frame.midY - 150)
                creditsButton.name = "creditsButton" // Assign a name to identify it
                addChild(creditsButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        // Check if "Start Game" button was tapped
        if touchedNode.name == "startButton" {
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
        }
        // Check if "High Scores" button was tapped
        else if touchedNode.name == "highScoresButton" {
            let highScoresScene = HighScoreScene(size: self.size)
            highScoresScene.scaleMode = .aspectFill
            self.view?.presentScene(highScoresScene, transition: SKTransition.fade(withDuration: 1.0))
        }
        // Check if "Credits" button was tapped
        else if touchedNode.name == "creditsButton" {
            let creditsScene = CreditsScene(size: self.size)
            creditsScene.scaleMode = .aspectFill
            self.view?.presentScene(creditsScene, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}


