//
//  ScoreManager.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-16.
//

import SpriteKit

class ScoreManager {
    private var score = 0
    private let scoreLabel: SKLabelNode

    init(frame: CGRect) {
        scoreLabel = SKLabelNode(fontNamed: "Papyrus")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor(red: 0.02, green: 0.15, blue: 0.02, alpha: 1.0)
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.height - 50)
        scoreLabel.zPosition = 300
    }

    func getScoreLabel() -> SKLabelNode {
        return scoreLabel
    }

    func incrementScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    func getScore() -> Int {
        return score
    }
}



