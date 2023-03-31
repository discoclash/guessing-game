//
//  ColorsViewController.swift
//  Right on Target
//
//  Created by G on 10.11.2022.
//

import UIKit

class ColorsViewController: UIViewController {

    // Экземпляр игры с цветами
    var game: Game<SecretColorValue>!
    
    // Номер правильной кнопки
    var correctButtonTag: Int = 0
    
    @IBOutlet var optionOne: UIButton!
    @IBOutlet var optionTwo: UIButton!
    @IBOutlet var optionThree: UIButton!
    @IBOutlet var optionFour: UIButton!
    
    // текстовая метка для вывода HEX
    @IBOutlet var hexLabel: UILabel!
   
    // вспомогательное свойство позволяющее работать с аутлетами кнопок как с коллекцией
    var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonCollection = [optionOne, optionTwo, optionThree, optionFour]
        // обновляем View
        updateScene()
    }
    
    private func updateScene() {
        let secretColorValue = game.secretValue.value
        updateSecretColorLabel(withText: secretColorValue)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    // MARK: - Взаимодействие View - Model
    // Проверка выбранного цвета
    @IBAction func compareValue(sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = sender.backgroundColor!.getByHEXString()
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
        // проверяем, окончена ли игра
        if game.isGameEnded {
            showAlert(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateScene()
    }
    
    // MARK: - Обновление View
    
    // Обновление текста загаданного цвета
    private func updateSecretColorLabel(withText hex: String) {
        hexLabel.text = hex
    }
    // Обновление фонового цвета кнопок
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        //определяем какая кнопуа будет правильной
        correctButtonTag = (1...4).randomElement()!
        buttonCollection.forEach() {button in
            if button.tag == correctButtonTag {
                button.backgroundColor = UIColor(hex: secretValue.value)
            } else {
                var copySecretValue = secretValue
                copySecretValue.getRandomValue()
                button.backgroundColor = UIColor(hex: copySecretValue.value)
            }
        }
    }
    // Отображение окна со счетом
    private func showAlert(score: Int) {
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы заработали \(score) очко(в)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
        self.present(alert, animated: true)
    }
}
