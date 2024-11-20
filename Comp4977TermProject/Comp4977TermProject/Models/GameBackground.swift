//
//  GameScene.swift
//  Comp4977TermProject
//
//  Created by Parin Ravanbakhsh on 2024-11-19.
//

import SpriteKit

class GameBackground: SKScene {
    
    override func didMove(to view: SKView) {
        // Set the background color (optional, for any gaps or testing)
        self.backgroundColor = .blue
        
        // Add each layer as a sprite node
        addBackgroundLayer(named: "Layer_0011_0", zPosition: 0) // Bottommost layer
        addBackgroundLayer(named: "Layer_0010_1", zPosition: 1)
        addBackgroundLayer(named: "Layer_0009_2", zPosition: 2)
        addBackgroundLayer(named: "Layer_0008_3", zPosition: 3)
        addBackgroundLayer(named: "Layer_0007_Lights", zPosition: 4)
        addBackgroundLayer(named: "Layer_0006_4", zPosition: 5)
        addBackgroundLayer(named: "Layer_0005_5", zPosition: 6)
        addBackgroundLayer(named: "Layer_0004_Lights", zPosition: 7)
        addBackgroundLayer(named: "Layer_0003_6", zPosition: 8)
        addBackgroundLayer(named: "Layer_0002_7", zPosition: 9) // Topmost layer
    }
    
    func addBackgroundLayer(named imageName: String, zPosition: CGFloat) {
        // Create a sprite node with the image
        let layerNode = SKSpriteNode(imageNamed: imageName)
        
        // Set the size of the node to match the screen size
        layerNode.size = self.size
        layerNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        layerNode.zPosition = zPosition
        
        // Add the node to the scene
        self.addChild(layerNode)
    }
}
