//
//  Untitled.swift
//  Comp4977TermProject
//
//  Created by Sukhraj Sidhu on 2024-11-18.
//

import CoreData
import UIKit

class HighScoreManager {
    static let shared = HighScoreManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HighScoreModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data error: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveHighScore(name: String, score: Int64) {
        let newHighScore = HighScore(context: context)
        newHighScore.name = name
        newHighScore.score = score
        newHighScore.date = Date()
        
        do {
            try context.save()
//            trimHighScores() // Ensure only top 5 scores are kept
        } catch {
            print("Failed to save high score: \(error)")
        }
    }
    
    func fetchHighScores() -> [HighScore] {
        let request: NSFetchRequest<HighScore> = HighScore.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        request.fetchLimit = 5 // Get top 5 scores
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch high scores: \(error)")
            return []
        }
    }
    
    // Trim high scores to the top 5
//    private func trimHighScores() {
//        let highScores = fetchHighScores()
//        
//        // If there are more than 5 scores, delete the extras
//        if highScores.count > 5 {
//            let scoresToRemove = highScores.suffix(from: 5) // All scores after the top 5
//            for score in scoresToRemove {
//                context.delete(score)
//            }
//            
//            do {
//                try context.save()
//            } catch {
//                print("Failed to trim high scores: \(error)")
//            }
//        }
//    }
}
