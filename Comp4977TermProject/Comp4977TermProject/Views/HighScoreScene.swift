//
//  HighScoreScene.swift
//  Comp4977TermProject
//
//  Created by Sukhraj Sidhu on 2024-11-18.
//

import SpriteKit

class HighScoreScene: SKScene {
    private let blackBoxHeightRatio: CGFloat = 0.6 // Black box height ratio
    
    override func didMove(to view: SKView) {
        // Add the layered game background
        addGameBackground()
        
        // Add a rounded black box to display high scores
        let blackBoxHeight = frame.height * blackBoxHeightRatio
        let fadedBackground = SKShapeNode(rectOf: CGSize(width: frame.width * 0.8, height: blackBoxHeight), cornerRadius: 20)
        fadedBackground.fillColor = UIColor.black.withAlphaComponent(0.5)
        fadedBackground.strokeColor = .clear
        fadedBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        fadedBackground.zPosition = 10
        addChild(fadedBackground)
        
        // Add stylized title (outside the black box)
        addStylizedTitle()
        
        // Fetch and display high scores inside the black box
        displayHighScores(on: fadedBackground)
        
        // Add a rustic "Back" button
        addBackButton()
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
    
    private func addGameBackground() {
        let background = GameBackground()
        background.position = CGPoint.zero // Align with the screen
        background.zPosition = -1 // Ensure it's behind everything else
        addChild(background)
    }
    
    private func addStylizedTitle() {
        // Create a shadow effect for the title
        let shadowLabel = SKLabelNode(fontNamed: "Papyrus")
        shadowLabel.text = "High Scores"
        shadowLabel.fontSize = 50
        shadowLabel.fontColor = UIColor.black.withAlphaComponent(0.7)
        shadowLabel.position = CGPoint(x: frame.midX + 5, y: frame.height * 0.85 - 5) // Slight offset for shadow
        shadowLabel.zPosition = 9
        addChild(shadowLabel)
        
        // Main title
        let titleLabel = SKLabelNode(fontNamed: "Papyrus")
        titleLabel.text = "High Scores"
        titleLabel.fontSize = 50
        titleLabel.fontColor = UIColor(red: 0.8, green: 0.9, blue: 0.6, alpha: 1.0) // Light green for forest vibes
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.85)
        titleLabel.zPosition = 10
        addChild(titleLabel)
    }
    
    private func displayHighScores(on background: SKShapeNode) {
        let highScores = HighScoreManager.shared.fetchHighScores()
        let maxVisibleScores = 10 // Number of scores to display
        var currentY = background.frame.maxY - 50 // Start slightly below the top of the black box
        let spacing: CGFloat = 40 // Spacing between each score label
        
        for (index, highScore) in highScores.prefix(maxVisibleScores).enumerated() {
            let playerName = highScore.name ?? "Unknown" // Safely unwrap or provide a default value
            let scoreLabel = SKLabelNode(fontNamed: "Papyrus") // Rustic font for high scores
            scoreLabel.text = "\(index + 1). \(playerName): \(highScore.score)"
            scoreLabel.fontSize = 30
            scoreLabel.fontColor = .white
            scoreLabel.position = CGPoint(x: background.position.x, y: currentY)
            scoreLabel.zPosition = 11
            addChild(scoreLabel)
            currentY -= spacing // Move down for the next score
        }
    }
    
    private func addBackButton() {
        // Button background with a wooden texture
        let buttonBackground = SKSpriteNode(imageNamed: "wood")
        buttonBackground.size = CGSize(width: 150, height: 50)
        buttonBackground.position = CGPoint(x: frame.midX, y: frame.height * 0.1)
        buttonBackground.zPosition = 9
        buttonBackground.name = "backButton"
        addChild(buttonBackground)
        
        // Button text
        let buttonLabel = SKLabelNode(fontNamed: "Papyrus")
        buttonLabel.text = "Back"
        buttonLabel.fontSize = 25
        buttonLabel.fontColor = UIColor(red: 0.9, green: 0.8, blue: 0.7, alpha: 1.0) // Beige for a natural look
        buttonLabel.position = CGPoint(x: 0, y: -10) // Center the text on the button
        buttonLabel.zPosition = 10
        buttonLabel.name = "backButton" // Assign same name for touch handling
        buttonBackground.addChild(buttonLabel)
    }
}
