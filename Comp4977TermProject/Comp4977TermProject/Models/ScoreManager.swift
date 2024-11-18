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
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.height - 50)
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



