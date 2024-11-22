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
        addGameBackground()
        
        // Add a rounded, faded black background box
        let blackBoxHeight = frame.height * blackBoxHeightRatio
        let fadedBackground = SKShapeNode(rectOf: CGSize(width: frame.width * 0.8, height: blackBoxHeight), cornerRadius: 20)
        fadedBackground.fillColor = UIColor.black.withAlphaComponent(0.5)
        fadedBackground.strokeColor = .clear
        fadedBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        fadedBackground.zPosition = 10
        addChild(fadedBackground)
        
        // Add stylized title
        addStylizedTitle()
        
        // Credits content
        displayCreditsContent(in: fadedBackground)
        
        // Add a rustic "Back" button
        addBackButton()
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
    
    private func addGameBackground() {
        let background = GameBackground()
        background.position = CGPoint.zero // Align with the screen
        background.zPosition = -1 // Ensure it's behind everything else
        addChild(background)
    }
    
    private func addStylizedTitle() {
        // Create a shadow effect for the title
        let shadowLabel = SKLabelNode(fontNamed: "Papyrus")
        shadowLabel.text = "Credits"
        shadowLabel.fontSize = 60
        shadowLabel.fontColor = UIColor.black.withAlphaComponent(0.7)
        shadowLabel.position = CGPoint(x: frame.midX + 5, y: frame.height * 0.85 - 5) // Slight offset for shadow
        shadowLabel.zPosition = 9
        addChild(shadowLabel)
        
        // Main title
        let titleLabel = SKLabelNode(fontNamed: "Papyrus")
        titleLabel.text = "Credits"
        titleLabel.fontSize = 60
        titleLabel.fontColor = UIColor(red: 0.8, green: 0.9, blue: 0.6, alpha: 1.0) // Light green for forest vibes
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.85)
        titleLabel.zPosition = 10
        addChild(titleLabel)
    }
    
    private func displayCreditsContent(in background: SKShapeNode) {
        let gameDesign = ["Helen Liu", "Parin Ravanbakhsh"]
        let gameLogic = ["Brett Reader", "Sukhraj Sidhu", "Sungmok Cho"]
        let graphics = ["itch.io"]
        
        // Initial position for the content
        var currentY = background.frame.maxY - 40 // Start near the top of the black box
        
        // Add Game Design and Game Logic side by side
        let columnSpacing: CGFloat = 100 // Horizontal spacing between the two columns
        let columnLeftX = background.position.x - columnSpacing
        let columnRightX = background.position.x + columnSpacing
        
        // Section titles
        addSectionTitle("Game Design", at: CGPoint(x: columnLeftX, y: currentY))
        addSectionTitle("Game Logic", at: CGPoint(x: columnRightX, y: currentY))
        
        currentY -= 30 // Move down for the names
        
        // Add names under Game Design
        for (index, name) in gameDesign.enumerated() {
            addSectionContent(name, at: CGPoint(x: columnLeftX, y: currentY - CGFloat(index * 20)))
        }
        
        // Add names under Game Logic
        for (index, name) in gameLogic.enumerated() {
            addSectionContent(name, at: CGPoint(x: columnRightX, y: currentY - CGFloat(index * 20)))
        }
        
        // Adjust currentY based on the larger column
        currentY -= max(CGFloat(gameDesign.count), CGFloat(gameLogic.count)) * 20 + 30
        
        // Add Graphics section spanning both columns
        addSectionTitle("Graphics", at: CGPoint(x: background.position.x, y: currentY))
        
        currentY -= 30 // Move down for the names
        
        for (index, name) in graphics.enumerated() {
            addSectionContent(name, at: CGPoint(x: background.position.x, y: currentY - CGFloat(index * 20)))
        }
    }
    
    private func addSectionTitle(_ text: String, at position: CGPoint) {
        let sectionLabel = SKLabelNode(fontNamed: "Papyrus")
        sectionLabel.text = text
        sectionLabel.fontSize = 20
        sectionLabel.fontColor = .white
        sectionLabel.position = position
        sectionLabel.zPosition = 11
        addChild(sectionLabel)
    }
    
    private func addSectionContent(_ text: String, at position: CGPoint) {
        let nameLabel = SKLabelNode(fontNamed: "Papyrus")
        nameLabel.text = text
        nameLabel.fontSize = 15
        nameLabel.fontColor = .white
        nameLabel.position = position
        nameLabel.zPosition = 11
        addChild(nameLabel)
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
