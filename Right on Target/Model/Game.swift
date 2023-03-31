//
//  File.swift
//  Right on Target
//
//  Created by G on 09.11.2022.
//

import Foundation

protocol GameProtocol {
    associatedtype SecretType
    // Количество заработанных очков
    var score: Int { get }
    // Генератор случайного значения
    var secretValue: SecretType { get }
    // Проверяет, окончена ли игра
    var isGameEnded: Bool { get }
    // начинает новую игру
    func restartGame()
    // начминает новый раунд
    func startNewRound()
    // сравнение значения с заданным и подсчет очков
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: GeneratorProtocol> : GameProtocol {
   
    typealias SecretType = T
    var score: Int = 0
    // секретное значение
    var secretValue: T
    // замыкание производит сравнение значения и возвращает заработанные очки
    private let compareClosure: (T, T) -> Int
    private var roundsCount: Int!
    private var currentRoundNumber: Int = 0
    var isGameEnded: Bool {
        if currentRoundNumber == roundsCount {
            return true
        } else {
            return false
        }
    }
    
    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRound()
    }
    
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentRoundNumber += 1
        self.secretValue.getRandomValue()
    }
    
    func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure (secretValue, userValue)
    }
    
}



