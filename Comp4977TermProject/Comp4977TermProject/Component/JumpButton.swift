//
//  JumpButton.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class JumpButton: SKSpriteNode {
    init() {
        super.init(texture: nil, color: .blue, size: CGSize(width: 100, height: 50))
        self.name = "jumpButton"
        self.position = CGPoint(x: UIScreen.main.bounds.midX, y: 200)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
