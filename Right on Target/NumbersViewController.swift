//
//  ViewController.swift
//  Right on Target
//
//  Created by G on 07.11.2022.
//

import UIKit

class NumbersViewController: UIViewController {
    

    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    
    var game: Game<SecretNumericValue>!
    
    // MARK: Взаимолействие View - Модель
    
    @IBAction func checkNumber () {
        // вычисляем очки за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value.rounded())
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // проверяем, закончена ли игра
        if game.isGameEnded {
            // показываем окно с итогами
            showAlert(score: game.score)
            // Рестарт игры
            game.restartGame()
            } else {
                // начинаем новый раунд
                game.startNewRound()
            }
        updateValueInLabel(value: game.secretValue.value)
    }
    
    // MARK: Обновление View
    
    private func updateValueInLabel(value: Int) {
        label.text = String(value)
    }
    
    private func showAlert(score: Int) {
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы заработали \(score) очко(в)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: ЖИзненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        updateValueInLabel(value: game.secretValue.value)
        }
    
}

