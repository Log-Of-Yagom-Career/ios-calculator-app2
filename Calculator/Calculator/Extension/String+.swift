//
//  Calculator - String+.swift
//  Created by Rhode, Songjun.
//  Copyright © yagom. All rights reserved.
//

import Foundation

extension String {
    var stringWithComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let splittedNumber = self.components(separatedBy: ".")
        
        if splittedNumber.count == 1 {
            guard let decimalValue = Decimal(string: splittedNumber[0]) else { return self }
            
            return numberFormatter.string(from: decimalValue as NSNumber) ?? self
        } else if splittedNumber.count == 2 {
            guard let decimalNumberBeforeDecimalPoint = Decimal(string: splittedNumber[0]) else { return self }
            
            let numberBeforeDecimalPoint = numberFormatter.string(from: decimalNumberBeforeDecimalPoint as NSNumber) ?? self
            let wholeNumber = numberBeforeDecimalPoint + "." + splittedNumber[1]
            
            return wholeNumber
        }
        
        return self
    }
    
    var floorIfZero: String {
        let splittedNumber = self.components(separatedBy: ".")
        guard splittedNumber.count == 2 else { return self }
        
        var numberAfterDecimalPoint = splittedNumber[1]
        
        while let last = numberAfterDecimalPoint.last {
            if last == "0" {
                numberAfterDecimalPoint.removeLast()
            } else { break }
        }
        
        if numberAfterDecimalPoint.isEmpty {
            return splittedNumber[0]
        } else {
            return splittedNumber[0] + "." + numberAfterDecimalPoint
        }
    }
    
    func convertToExponent() -> String {
        guard self.count > 20 else {
            return self
        }
        
        let splittedNumber = self.components(separatedBy: NameSpace.dot)
        let digit = splittedNumber[0].count - 1
        let stringToBeRounded: String
        
        if splittedNumber.count == 1 {
            stringToBeRounded = splittedNumber[0]
        } else {
            stringToBeRounded = splittedNumber[0] + splittedNumber[1]
        }
        
        var newString = NameSpace.emptyString
        
        for number in stringToBeRounded {
            newString += String(number)
            if newString.count == 17 {
                break
            }
        }
        
        newString.insert(Character(NameSpace.dot), at: newString.index(newString.startIndex, offsetBy: 1))
        newString += "e" + String(digit)
        
        return newString
    }
    
    func split(with target: Character) -> [String] {
        
        return components(separatedBy: String(target))
    }
}
