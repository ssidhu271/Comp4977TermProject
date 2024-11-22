//
//  SpriteSheetUtils.swift
//  Comp4977TermProject
//
//  Created by Parin Ravanbakhsh on 2024-11-19.
//

import SpriteKit

func extractFrames(from spriteSheet: SKTexture, row: Int, columns: Int, totalRows: Int) -> [SKTexture] {
    var frames: [SKTexture] = []
    
    let frameWidth = spriteSheet.size().width / CGFloat(columns)
    let frameHeight = spriteSheet.size().height / CGFloat(totalRows)
    
    for column in 0..<columns {
        let frame = CGRect(
            x: CGFloat(column) * frameWidth / spriteSheet.size().width,
            y: CGFloat(totalRows - 1 - row) * frameHeight / spriteSheet.size().height,
            width: frameWidth / spriteSheet.size().width,
            height: frameHeight / spriteSheet.size().height
        )
        frames.append(SKTexture(rect: frame, in: spriteSheet))
    }
    return frames
}
