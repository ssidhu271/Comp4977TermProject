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
        } catch {
            print("Failed to save high score: \(error)")
        }
    }

    func fetchHighScores() -> [HighScore] {
        let request: NSFetchRequest<HighScore> = HighScore.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        request.fetchLimit = 10 // Get top 10 scores

        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch high scores: \(error)")
            return []
        }
    }
}
