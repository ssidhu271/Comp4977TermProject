//
//  GameViewController.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-16.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            let scene = MainMenuScene(size: view.bounds.size) // Start with the Main Menu
            scene.scaleMode = .aspectFill
            view.presentScene(scene)

            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
