//
//  Extensions.swift
//  Right on Target
//
//  Created by G on 11.11.2022.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        return nil
    }
    
    func getByHEXString() -> String {
        let red = UInt8(CGFloat(255)*self.cgColor.components![0])
        let green = UInt8(CGFloat(255)*self.cgColor.components![1])
        let blue = UInt8(CGFloat(255)*self.cgColor.components![2])
        // Переводим данные об интенсивности каналов в 16-тиричную систему счисления
        // Для этого используем встроенный в тип String инициализатор
        //  позволяющий изменить систему счисления переданного числового значения
        var redPart = String(red, radix: 16, uppercase: true)
        if red <= 16 {
            redPart = "0\(redPart)"
        }
        var greenPart = String(green, radix: 16, uppercase: true)
        if green <= 16 {
            greenPart = "0\(greenPart)"
        }
        var bluePart = String(blue, radix: 16, uppercase: true)
        if blue <= 16 {
            bluePart = "0\(bluePart)"
        }
        
        return "#\(redPart)\(greenPart)\(bluePart)"
    }
}




