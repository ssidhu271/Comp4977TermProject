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

        // Add title label (outside the black box)
        let titleLabel = SKLabelNode(fontNamed: "Arial")
        titleLabel.text = "High Scores"
        titleLabel.fontSize = 60
        titleLabel.fontColor = .yellow
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.85)
        titleLabel.zPosition = 10
        addChild(titleLabel)

        // Fetch and display high scores inside the black box
        let highScores = HighScoreManager.shared.fetchHighScores()
        let maxVisibleScores = 10 // Number of scores to display
        var currentY = fadedBackground.frame.maxY - 50 // Start slightly below the top of the black box
        let spacing: CGFloat = 40 // Spacing between each score label

        for (index, highScore) in highScores.prefix(maxVisibleScores).enumerated() {
            let playerName = highScore.name ?? "Unknown" // Safely unwrap or provide a default value
            let scoreLabel = SKLabelNode(fontNamed: "Arial")
            scoreLabel.text = "\(index + 1). \(playerName): \(highScore.score)"
            scoreLabel.fontSize = 30
            scoreLabel.fontColor = .white
            scoreLabel.position = CGPoint(x: fadedBackground.position.x, y: currentY)
            scoreLabel.zPosition = 10
            addChild(scoreLabel)
            currentY -= spacing // Move down for the next score
        }

        // Add back button
        let backButton = SKLabelNode(fontNamed: "Arial")
        backButton.text = "Back"
        backButton.fontSize = 25
        backButton.fontColor = .white
        backButton.position = CGPoint(x: frame.midX, y: frame.height * 0.1)
        backButton.zPosition = 10
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
    
    private func addGameBackground() {
        let background = GameBackground()
        background.position = CGPoint.zero // Align with the screen
        background.zPosition = -1 // Ensure it's behind everything else
        addChild(background)
    }
}
