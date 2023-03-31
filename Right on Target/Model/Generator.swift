//
//  VulueGenerator.swift
//  Right on Target
//
//  Created by G on 09.11.2022.
//

import Foundation

// Протокол, на основании уоторого будет создано значение
protocol GeneratorProtocol {
    //ассоцитированный тип, который будет необходимо определить
    associatedtype ValueType
    var value: ValueType { get }
    mutating func getRandomValue ()
}

struct ValueGenerator<T: Equatable>: GeneratorProtocol {
    typealias ValueType = T
    var value: T
    private let randomValueClosure: () -> T
    init(randomValueClosure: @escaping () -> T) {
        self.randomValueClosure = randomValueClosure
        value = self.randomValueClosure()
    }
    
    //функция, выбрасывающая значение, в зависмости от замыкания
    mutating func getRandomValue() {
        value = self.randomValueClosure()
    }
}
typealias SecretNumericValue = ValueGenerator<Int>
typealias SecretColorValue = ValueGenerator<String>



