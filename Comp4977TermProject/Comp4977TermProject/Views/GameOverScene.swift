//
//  GameOverScene.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-18.
//

import SpriteKit

class GameOverScene: SKScene {
    private var finalScore: Int = 0
    private var nameTextField: UITextField?
    
    init(size: CGSize, finalScore: Int) {
        self.finalScore = finalScore
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        addGameBackground()
        
        // Add UI elements closer to the center of the screen
        addGameOverLabel()
        addFinalScoreLabel()
        
        // Positioning adjustments based on whether the score qualifies
        var buttonYOffset: CGFloat = -50
        
        // Only show the name input field and "Enter Your Name:" if the score qualifies
        if checkIfScoreQualifies() {
            addNameLabel()
            addNameInputField(to: view)
            buttonYOffset -= 60 // Push buttons further down to accommodate the name input
        }
        
        // Add buttons
        addButtons(withOffset: buttonYOffset)
    }
    
    override func willMove(from view: SKView) {
        // Remove the text field when leaving the scene
        nameTextField?.removeFromSuperview()
    }
    
    // MARK: - UI Setup
    
    private func addGameOverLabel() {
        // Create a shadow effect for the title
        let shadowLabel = SKLabelNode(fontNamed: "Papyrus")
        shadowLabel.text = "Game Over"
        shadowLabel.fontSize = 60
        shadowLabel.fontColor = UIColor.black.withAlphaComponent(0.7)
        shadowLabel.position = CGPoint(x: frame.midX + 5, y: frame.height * 0.75 - 2) // Offset for shadow
        shadowLabel.zPosition = 9
        addChild(shadowLabel)
        
        // Main title
        let titleLabel = SKLabelNode(fontNamed: "Papyrus")
        titleLabel.text = "Game Over"
        titleLabel.fontSize = 60
        titleLabel.fontColor = UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0) // Red for dramatic effect
        titleLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.75)
        titleLabel.zPosition = 10
        addChild(titleLabel)
    }
    
    private func addFinalScoreLabel() {
        let finalScoreLabel = SKLabelNode(fontNamed: "Papyrus")
        finalScoreLabel.text = "Final Score: \(finalScore)"
        finalScoreLabel.fontSize = 30
        finalScoreLabel.fontColor = UIColor(red: 0.9, green: 0.8, blue: 0.7, alpha: 1.0) // Beige color for consistency
        finalScoreLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.6)
        finalScoreLabel.zPosition = 10
        addChild(finalScoreLabel)
    }
    
    private func addNameLabel() {
        let nameLabel = SKLabelNode(fontNamed: "Papyrus")
        nameLabel.text = "Enter Your Name:"
        nameLabel.fontSize = 25
        nameLabel.fontColor = UIColor(red: 0.9, green: 0.8, blue: 0.7, alpha: 1.0) // Beige color for consistency
        nameLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        nameLabel.zPosition = 10
        addChild(nameLabel)
    }
    
    private func addNameInputField(to view: SKView) {
        // Create and configure the UITextField
        nameTextField = UITextField(frame: CGRect(x: view.frame.midX - 100, y: view.frame.midY + 20, width: 200, height: 40))
        nameTextField?.layer.zPosition = 10
        nameTextField?.placeholder = "Your Name"
        nameTextField?.borderStyle = .roundedRect
        nameTextField?.textAlignment = .center
        nameTextField?.backgroundColor = .white
        nameTextField?.autocorrectionType = .no
        nameTextField?.autocapitalizationType = .words
        view.addSubview(nameTextField!)
    }
    
    private func addButtons(withOffset offset: CGFloat) {
        // Add rustic "Restart" button
        addButtonContent(text: "Restart", position: CGPoint(x: frame.midX, y: frame.midY + offset), name: "restartButton")
        
        // Add rustic "Main Menu" button
        addButtonContent(text: "Main Menu", position: CGPoint(x: frame.midX, y: frame.midY + offset - 60), name: "mainMenuButton")
    }
    
    private func addButtonContent(text: String, position: CGPoint, name: String) {
        // Button background with a wooden texture
        let buttonBackground = SKSpriteNode(imageNamed: "wood")
        buttonBackground.size = CGSize(width: 200, height: 50)
        buttonBackground.position = position
        buttonBackground.zPosition = 9
        buttonBackground.name = name
        addChild(buttonBackground)
        
        // Button text
        let buttonLabel = SKLabelNode(fontNamed: "Papyrus")
        buttonLabel.text = text
        buttonLabel.fontSize = 25
        buttonLabel.fontColor = UIColor(red: 0.9, green: 0.8, blue: 0.7, alpha: 1.0) // Beige color for a natural look
        buttonLabel.position = CGPoint(x: 0, y: -10) // Center the text on the button
        buttonLabel.zPosition = 10
        buttonLabel.name = name // Assign same name for touch handling
        buttonBackground.addChild(buttonLabel)
    }
    
    private func addGameBackground() {
        let background = GameBackground()
        background.position = CGPoint.zero // Align with the screen
        background.zPosition = -1 // Ensure it's behind everything else
        addChild(background)
    }
    
    // MARK: - Scoring Logic
    
    private func checkIfScoreQualifies() -> Bool {
        let highScores = HighScoreManager.shared.fetchHighScores()
        
        // If fewer than 5 scores exist, it qualifies
        if highScores.count < 5 {
            return true
        }
        
        // Qualifies if the score is higher than the current fifth-place score
        if let fifthPlaceScore = highScores.last?.score {
            return finalScore > Int(fifthPlaceScore)
        }
        
        return false
    }
    
    private func saveHighScoreIfNeeded() {
        guard let playerName = nameTextField?.text, !playerName.isEmpty else {
            print("Name is empty. Not saving high score.")
            return
        }
        
        let highScores = HighScoreManager.shared.fetchHighScores()
        
        // Save the score if it qualifies for the top 5
        if highScores.count < 5 || finalScore > (highScores.last?.score ?? 0) {
            HighScoreManager.shared.saveHighScore(name: playerName, score: Int64(finalScore))
        }
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        if touchedNode.name == "restartButton" {
            saveHighScoreIfNeeded()
            nameTextField?.removeFromSuperview()
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
        } else if touchedNode.name == "mainMenuButton" {
            saveHighScoreIfNeeded()
            nameTextField?.removeFromSuperview()
            let mainMenuScene = MainMenuScene(size: self.size)
            mainMenuScene.scaleMode = .aspectFill
            self.view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
