import UIKit
struct CalculatorManager {
    private var inputNumber = "" {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "operand"), object: convertFormat(inputNumber))
        }
    }
    private var inputOperator = "" {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "operator"), object: inputOperator)
        }
    }
    private(set) var arithmetic = "" {
        didSet {
            var sendValue = inputOperator + " " + inputNumber
            if arithmetic == "" {
                sendValue = ""
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "arithmetic"), object: sendValue)
        }
    }
    private var isPositiveNumber = true
    
    var isNumberEmpty: Bool {
       return inputNumber.isEmpty || inputNumber == "0"
    }
    var isArithmeticEmpty: Bool {
        return arithmetic.isEmpty
    }
    
    private func convertFormat(_ number: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumSignificantDigits = 20

        guard let double = Double(number) else {
            return ""
        }
        
        return numberFormatter.string(from: NSNumber(value: double)) ?? "0"
    }
    
    mutating func updateInputNumber(with number: String) {
        if inputNumber.contains(".") && number == "." {
            return
        }
        
        if (inputNumber == "" || inputNumber == "0") && (number == "0" || number == "00") {
            inputNumber = "0"
        } else if inputNumber == "" && number == "." {
            inputNumber = "0."
        } else if inputNumber == "0" && number != "."{
            inputNumber = number
        } else {
            inputNumber += number
        }
    }
    
    mutating func updateOperatorInput(`operator`: String) {
        inputOperator = `operator`
    }
    
    mutating func resetCalculator() {
        arithmetic = ""
        isPositiveNumber = true
    }
    
    mutating func removeAll() {
        resetCalculator()
        resetInput(inputNumber: true, inputOperator: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "remove"), object: "")
    }
    
    mutating func resetInput(inputNumber: Bool, inputOperator: Bool) {
        if inputNumber {
            self.inputNumber = "0"
        }
        
        if inputOperator {
            self.inputOperator = ""
        }
    }
    
    mutating func convertSign() {
        if inputNumber == "0" || isNumberEmpty {
            return
        }
        
        if isPositiveNumber {
            inputNumber = "-" + inputNumber
            isPositiveNumber = false
        } else {
            inputNumber = inputNumber.replacingOccurrences(of: "-", with: "")
            isPositiveNumber = true
        }
    }
    
    mutating func appendArithmetic() {
        arithmetic = arithmetic + inputOperator + inputNumber
    }
}
