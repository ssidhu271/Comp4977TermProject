//
//  JumpButton.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-17.
//

import SpriteKit

class JumpButton: SKSpriteNode {
    init() {
        //load the jump button
        let buttonTexture = SKTexture(imageNamed: "jump_button")
        super.init(texture: buttonTexture, color: .clear, size: CGSize(width: 50, height: 50))
        self.name = "jumpButton"
        self.zPosition =  15
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
