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
        self.backgroundColor = .black

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
        let gameOverLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(gameOverLabel)
    }

    private func addFinalScoreLabel() {
        let finalScoreLabel = SKLabelNode(fontNamed: "Arial")
        finalScoreLabel.text = "Final Score: \(finalScore)"
        finalScoreLabel.fontSize = 30
        finalScoreLabel.fontColor = .white
        finalScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        addChild(finalScoreLabel)
    }

    private func addNameLabel() {
        let nameLabel = SKLabelNode(fontNamed: "Arial")
        nameLabel.text = "Enter Your Name:"
        nameLabel.fontSize = 25
        nameLabel.fontColor = .white
        nameLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        nameLabel.name = "nameLabel" // Add a name for identification
        addChild(nameLabel)
    }

    private func addNameInputField(to view: SKView) {
        // Create and configure the UITextField
        nameTextField = UITextField(frame: CGRect(x: view.frame.midX - 100, y: view.frame.midY + 20, width: 200, height: 40))
        nameTextField?.placeholder = "Your Name"
        nameTextField?.borderStyle = .roundedRect
        nameTextField?.textAlignment = .center
        nameTextField?.backgroundColor = .white
        nameTextField?.autocorrectionType = .no
        nameTextField?.autocapitalizationType = .words
        view.addSubview(nameTextField!)
    }

    private func addButtons(withOffset offset: CGFloat) {
        // Restart button
        let restartButton = SKLabelNode(fontNamed: "Arial")
        restartButton.text = "Restart"
        restartButton.fontSize = 30
        restartButton.fontColor = .green
        restartButton.position = CGPoint(x: frame.midX, y: frame.midY + offset)
        restartButton.name = "restartButton"
        addChild(restartButton)

        // Main menu button
        let mainMenuButton = SKLabelNode(fontNamed: "Arial")
        mainMenuButton.text = "Main Menu"
        mainMenuButton.fontSize = 30
        mainMenuButton.fontColor = .blue
        mainMenuButton.position = CGPoint(x: frame.midX, y: frame.midY + offset - 50)
        mainMenuButton.name = "mainMenuButton"
        addChild(mainMenuButton)
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

        nameTextField?.removeFromSuperview()

        if touchedNode.name == "restartButton" {
            saveHighScoreIfNeeded()
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
        } else if touchedNode.name == "mainMenuButton" {
            saveHighScoreIfNeeded()
            let mainMenuScene = MainMenuScene(size: self.size)
            mainMenuScene.scaleMode = .aspectFill
            self.view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
