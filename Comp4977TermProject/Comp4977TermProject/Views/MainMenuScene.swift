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

        // Add "Start Game" button
        let startButton = SKLabelNode(fontNamed: "Arial")
        startButton.text = "Start Game"
        startButton.fontSize = 40
        startButton.fontColor = .white
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.name = "startButton" // Assign a name to identify it
        addChild(startButton)
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
    }
}

