//
//  MainMenuScene.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-16.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Add the layered game background
        addGameBackground()
        
        // Add stylized title at the top
        addStylizedTitle()
        
        // Add buttons
        addButton(text: "Start Game", position: CGPoint(x: frame.midX, y: frame.midY - 50), name: "startButton")
        addButton(text: "High Scores", position: CGPoint(x: frame.midX, y: frame.midY - 100), name: "highScoresButton")
        addButton(text: "Credits", position: CGPoint(x: frame.midX, y: frame.midY - 150), name: "creditsButton")
        
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
    
    private func addGameBackground() {
        let background = GameBackground()
        background.position = CGPoint.zero // Align with the screen
        background.zPosition = -1 // Ensure it's behind everything else
        addChild(background)
    }
    
    private func addStylizedTitle() {
        // Create a shadow effect for the title
        let shadowLabel = SKLabelNode(fontNamed: "Papyrus")
        shadowLabel.text = "Forest Runner"
        shadowLabel.fontSize = 80
        shadowLabel.fontColor = UIColor.black.withAlphaComponent(0.7)
        shadowLabel.position = CGPoint(x: frame.midX + 5, y: frame.height * 0.65 - 5) // Offset slightly for shadow
        shadowLabel.zPosition = 9
        addChild(shadowLabel)
        
        // Main title
        let titleLabel = SKLabelNode(fontNamed: "Papyrus")
        titleLabel.text = "Forest Runner"
        titleLabel.fontSize = 80
        titleLabel.fontColor = UIColor(red: 0.8, green: 0.9, blue: 0.6, alpha: 1.0) // Light green color for forest vibes
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.65)
        titleLabel.zPosition = 10
        addChild(titleLabel)
    }
    
    private func addButton(text: String, position: CGPoint, name: String) {
        // Button background with a wooden texture
        let buttonBackground = SKSpriteNode(imageNamed: "wood")
        buttonBackground.size = CGSize(width: 225, height: 45)
        buttonBackground.position = position
        buttonBackground.zPosition = 9
        buttonBackground.name = name // Assign a name for interaction
        addChild(buttonBackground)
        
        // Button text
        let buttonLabel = SKLabelNode(fontNamed: "Papyrus") // Rustic-themed font
        buttonLabel.text = text
        buttonLabel.fontSize = 25
        buttonLabel.fontColor = UIColor(red: 0.9, green: 0.8, blue: 0.7, alpha: 1.0) // Beige color for a natural look
        buttonLabel.position = CGPoint(x: 0, y: -10) // Center the text on the button
        buttonLabel.zPosition = 10
        buttonLabel.name = name // Assign same name for touch handling
        buttonBackground.addChild(buttonLabel)
    }
}


