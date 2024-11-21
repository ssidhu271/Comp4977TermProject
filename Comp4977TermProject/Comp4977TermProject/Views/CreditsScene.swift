//
//  CreditsScene.swift
//  Comp4977TermProject
//
//  Created by Helen Liu on 2024-11-20.
//

import SpriteKit

class CreditsScene: SKScene {
    private let blackBoxHeightRatio: CGFloat = 0.65 // Black box height ratio

    override func didMove(to view: SKView) {
        // Set background color
        self.backgroundColor = .blue

        // Add a rounded, faded black background box
        let blackBoxHeight = frame.height * blackBoxHeightRatio
        let fadedBackground = SKShapeNode(rectOf: CGSize(width: frame.width * 0.8, height: blackBoxHeight), cornerRadius: 20)
        fadedBackground.fillColor = UIColor.black.withAlphaComponent(0.5)
        fadedBackground.strokeColor = .clear
        fadedBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(fadedBackground)

        // Add title
        let titleLabel = SKLabelNode(fontNamed: "Arial")
        titleLabel.text = "Credits"
        titleLabel.fontSize = 60
        titleLabel.fontColor = .yellow
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.85)
        addChild(titleLabel)

        // Credits content
        let gameDesign = ["Helen Liu", "Parin Ravanbakhsh"]
        let gameLogic = ["Brett Reader", "Sukhraj Sidhu", "Sungmok Cho"]
        let graphics = ["itch.io"]

        // Initial position for the content
        var currentY = fadedBackground.frame.maxY - 40 // Start near the top of the black box

        // Add Game Design and Game Logic side by side
        let columnSpacing: CGFloat = 100 // Horizontal spacing between the two columns
        let columnLeftX = fadedBackground.position.x - columnSpacing
        let columnRightX = fadedBackground.position.x + columnSpacing

        // Section titles
        let gameDesignLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        gameDesignLabel.text = "Game Design"
        gameDesignLabel.fontSize = 20
        gameDesignLabel.fontColor = .white
        gameDesignLabel.position = CGPoint(x: columnLeftX, y: currentY)
        addChild(gameDesignLabel)

        let gameLogicLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        gameLogicLabel.text = "Game Logic"
        gameLogicLabel.fontSize = 20
        gameLogicLabel.fontColor = .white
        gameLogicLabel.position = CGPoint(x: columnRightX, y: currentY)
        addChild(gameLogicLabel)

        currentY -= 30 // Move down for the names

        // Add names under Game Design
        for (index, name) in gameDesign.enumerated() {
            let nameLabel = SKLabelNode(fontNamed: "Arial")
            nameLabel.text = name
            nameLabel.fontSize = 15
            nameLabel.fontColor = .white
            nameLabel.position = CGPoint(x: columnLeftX, y: currentY - CGFloat(index * 20))
            addChild(nameLabel)
        }

        // Add names under Game Logic
        for (index, name) in gameLogic.enumerated() {
            let nameLabel = SKLabelNode(fontNamed: "Arial")
            nameLabel.text = name
            nameLabel.fontSize = 15
            nameLabel.fontColor = .white
            nameLabel.position = CGPoint(x: columnRightX, y: currentY - CGFloat(index * 20))
            addChild(nameLabel)
        }

        // Adjust currentY based on the larger column
        currentY -= max(CGFloat(gameDesign.count), CGFloat(gameLogic.count)) * 20 + 30

        // Add Graphics section spanning both columns
        let graphicsLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        graphicsLabel.text = "Graphics"
        graphicsLabel.fontSize = 20
        graphicsLabel.fontColor = .white
        graphicsLabel.position = CGPoint(x: fadedBackground.position.x, y: currentY)
        addChild(graphicsLabel)

        currentY -= 30 // Move down for the names

        for (index, name) in graphics.enumerated() {
            let nameLabel = SKLabelNode(fontNamed: "Arial")
            nameLabel.text = name
            nameLabel.fontSize = 15
            nameLabel.fontColor = .white
            nameLabel.position = CGPoint(x: fadedBackground.position.x, y: currentY - CGFloat(index * 20))
            addChild(nameLabel)
        }

        // Add "Back" button
        let backButton = SKLabelNode(fontNamed: "Arial")
        backButton.text = "Back"
        backButton.fontSize = 25
        backButton.fontColor = .white
        backButton.position = CGPoint(x: frame.midX, y: frame.height * 0.1)
        backButton.name = "backButton"
        addChild(backButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        // Check if "Back" button was tapped
        if touchedNode.name == "backButton" {
            let mainMenuScene = MainMenuScene(size: self.size)
            mainMenuScene.scaleMode = .aspectFill
            self.view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
