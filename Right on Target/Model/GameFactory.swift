//
//  File.swift
//  Right on Target
//
//  Created by G on 11.11.2022.
//

import Foundation

//сущность игра

final class GameFactory {
    
    static func getNumericGame() -> some GameProtocol {
        let minSecretValue = 1
        let maxSecretValue = 50
        let secretValue = SecretNumericValue() {
            return (minSecretValue...maxSecretValue).randomElement()!
        }
        return Game<SecretNumericValue>(secretValue: secretValue, rounds: 5) { secretValue, userValue in
            var compareResult: Int = 0
            if secretValue.value >= userValue.value {
                compareResult = maxSecretValue - (secretValue.value - userValue.value)
            } else if secretValue.value < userValue.value {
                compareResult = maxSecretValue - (userValue.value - secretValue.value)
            }
            return compareResult
        }
    }
    
    static func getColorGame() -> some GameProtocol {
        let secretValue = SecretColorValue() {
            var hex = "#"
            for _ in 1...3 {
                let color = (0x00...0xff).randomElement()!
                var rgbPart = String(color, radix: 16, uppercase: true)
                if color <= 16 {
                    rgbPart = "0\(rgbPart)"
                }
                hex += rgbPart
            }
            return hex
        }
        return Game<SecretColorValue>(secretValue: secretValue, rounds: 5) { secretValue, userValue in
            if secretValue.value == userValue.value {
                return 1
            }
            return 0
        }
    }
}
