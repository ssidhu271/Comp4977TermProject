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

        // Add UI elements using GameOverUI helper
        GameOverUI.addGameOverLabel(to: self)
        GameOverUI.addFinalScoreLabel(to: self, finalScore: finalScore)
        GameOverUI.addNameLabel(to: self)
        GameOverUI.addButtons(to: self)

        // Add Text Field for Name Input
        addNameInputField(to: view)
    }

    override func willMove(from view: SKView) {
        // Remove the text field when leaving the scene
        nameTextField?.removeFromSuperview()
    }

    private func addNameInputField(to view: SKView) {
        // Create and configure the UITextField
        nameTextField = UITextField(frame: CGRect(x: view.frame.midX - 100, y: view.frame.midY, width: 200, height: 40))
        nameTextField?.placeholder = "Your Name"
        nameTextField?.borderStyle = .roundedRect
        nameTextField?.textAlignment = .center
        nameTextField?.backgroundColor = .white
        nameTextField?.autocorrectionType = .no
        nameTextField?.autocapitalizationType = .words
        view.addSubview(nameTextField!)
    }

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


    private func saveHighScoreIfNeeded() {
        guard let playerName = nameTextField?.text, !playerName.isEmpty else {
            print("Name is empty. Not saving high score.")
            return
        }

        let highScores = HighScoreManager.shared.fetchHighScores()

        // Save the score if it qualifies
        if highScores.count < 10 || finalScore > (highScores.last?.score ?? 0) {
            HighScoreManager.shared.saveHighScore(name: playerName, score: Int64(finalScore))
        }
    }
}

