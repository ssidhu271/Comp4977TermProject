//
//  GameOverUI.swift
//  Comp4977TermProject
//
//  Created by Sukhraj Sidhu on 2024-11-18.
//

import SpriteKit

class GameOverUI {
    static func addGameOverLabel(to scene: SKScene) {
        let label = SKLabelNode(fontNamed: "Arial")
        label.text = "Game Over"
        label.fontSize = 50
        label.fontColor = .red
        label.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY + 150)
        scene.addChild(label)
    }

    static func addFinalScoreLabel(to scene: SKScene, finalScore: Int) {
        let label = SKLabelNode(fontNamed: "Arial")
        label.text = "Final Score: \(finalScore)"
        label.fontSize = 40
        label.fontColor = .white
        label.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY + 100)
        scene.addChild(label)
    }

    static func addButtons(to scene: SKScene) {
        let restartButton = ButtonNode(
            text: "Restart",
            fontSize: 40,
            fontColor: .blue,
            position: CGPoint(x: scene.frame.midX, y: scene.frame.midY - 150),
            name: "restartButton"
        )
        scene.addChild(restartButton)

        let mainMenuButton = ButtonNode(
            text: "Main Menu",
            fontSize: 40,
            fontColor: .green,
            position: CGPoint(x: scene.frame.midX, y: scene.frame.midY - 200),
            name: "mainMenuButton"
        )
        scene.addChild(mainMenuButton)
    }

    static func addNameLabel(to scene: SKScene) {
        let nameLabel = SKLabelNode(fontNamed: "Arial")
        nameLabel.text = "Enter Your Name:"
        nameLabel.fontSize = 30
        nameLabel.fontColor = .white
        nameLabel.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY + 50)
        scene.addChild(nameLabel)
    }
}

