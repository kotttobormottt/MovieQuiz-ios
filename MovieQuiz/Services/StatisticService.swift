//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Andrey Zharov on 14.01.2024.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    // метод сравнения по количеству верных ответов
    func checkBetterAnswer(checkAnswer: GameRecord) -> Bool {
        correct > checkAnswer.correct
    }
}

final class StatisticServiceImplementation: StatisticService {
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    
    var totalAccuracy: Double {
        get {
            let total = Double(userDefaults.integer(forKey: Keys.total.rawValue))
            let correct = Double(userDefaults.integer(forKey: Keys.correct.rawValue))
            return (correct/total)*100
        }
    }
    
    var gamesCount: Int {
        get {
            return userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
            let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }

            return record
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }

            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    var correctAnswers: Int {
        get {
            return userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    var totalQuestions: Int {
        get {
            return userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correctAnswers += count
        totalQuestions += amount
        let checkAnswer = GameRecord(correct: count, total: amount, date: Date.init())
        if bestGame.checkBetterAnswer(checkAnswer: checkAnswer) {
            bestGame = checkAnswer
        }
    }
}
