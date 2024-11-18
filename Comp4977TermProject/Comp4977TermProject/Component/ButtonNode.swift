//
//  ButtonNode.swift
//  Comp4977TermProject
//
//  Created by Sukhraj Sidhu on 2024-11-18.
//

import SpriteKit

class ButtonNode: SKLabelNode {
    init(text: String, fontSize: CGFloat, fontColor: UIColor, position: CGPoint, name: String) {
        super.init()
        self.text = text
        self.fontName = "Arial"
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.position = position
        self.name = name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

