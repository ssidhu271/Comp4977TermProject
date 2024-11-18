//
//  GamePhysicsCategories.swift
//  Comp4977TermProject
//
//  Created by sungmok cho on 2024-11-16.
//

import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let character: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
    static let ground: UInt32 = 0x1 << 2
    static let coin: UInt32 = 0x1 << 3
}
