//
//  Calculator.swift
//  Calculator
//
//  Created by JeongTaek Han on 2021/11/22.
//

import Foundation

struct Calculator {
    private(set) var currentInputOperand = LabelContents.defaultOperand
    private(set) var currentInputOperator = LabelContents.emptyString
    
    private var isEvaluated = false
    private var mathExpression: [String] = []
    
    mutating func touchNumberButton(_ number: String) {
        if isEvaluated { return }
        
        if number == LabelContents.pointSymbole && currentInputOperand.contains(LabelContents.pointSymbole) { return }
        
        if number == LabelContents.pointSymbole && currentInputOperand == LabelContents.defaultOperand {
            currentInputOperand += number
            return
        }
        
        if number == LabelContents.doubleZero && currentInputOperand == LabelContents.defaultOperand { return }
        
        if currentInputOperand == LabelContents.defaultOperand {
            updateCurrentInput(operandForm: number, operatorForm: currentInputOperator)
            return
        }
        
        currentInputOperand += number
    }
    
    mutating func touchOperatorButton(_ operatorSymbole: String) {
        if isEvaluated { return }
        
        if currentInputOperand == LabelContents.defaultOperand && mathExpression.isEmpty { return }
        
        if currentInputOperand == LabelContents.defaultOperand {
            updateCurrentInput(operandForm: currentInputOperand, operatorForm: operatorSymbole)
            return
        }
        
        if mathExpression.isEmpty {
            mathExpression += [currentInputOperand]
            updateCurrentInput(operatorForm: operatorSymbole)
            return
        }
        
        mathExpression += [currentInputOperator, currentInputOperand]
        updateCurrentInput(operatorForm: operatorSymbole)
    }
    
    mutating func touchSignChangeButton() {
        if currentInputOperand == LabelContents.defaultOperand { return }
        if isEvaluated { return }
        
        if currentInputOperand.hasPrefix(LabelContents.minusSignSymbole) {
            currentInputOperand.removeFirst()
            return
        }
        
        currentInputOperand.insert(contentsOf: LabelContents.minusSignSymbole, at: currentInputOperand.startIndex)
    }
    
    mutating func touchAllClearButton() {
        resetAllExpression()
    }
    
    mutating func touchClearEntryButton() {
        if isEvaluated == false {
            updateCurrentInput(operatorForm: currentInputOperator)
            return
        }
        
        resetAllExpression()
        isEvaluated = false
    }
    
    mutating func touchEvaluateButton() {
        if isEvaluated { return }
        
        mathExpression += [currentInputOperator, currentInputOperand]
        
        isEvaluated = true
        let stringFormula = mathExpression.joined()
        
        do {
            let result = try ExpressionParser.parse(from: stringFormula).result()
            updateCurrentInput(operandForm: String(result))
        } catch CalculatorError.divideByZero {
            updateCurrentInput(operandForm: LabelContents.notANumber)
        } catch {
            updateCurrentInput(operandForm: LabelContents.error)
        }
    }
    
    
    mutating private func updateCurrentInput(operandForm: String = LabelContents.defaultOperand, operatorForm: String = LabelContents.emptyString) {
        currentInputOperator = operatorForm
        currentInputOperand = operandForm
    }
    
    mutating private func resetAllExpression() {
        updateCurrentInput()
        mathExpression = []
        isEvaluated = false
    }
    
    private func initNumberFormatterForCalculator() -> Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 20
        formatter.roundingMode = .halfUp
        return formatter
    }
    
    private struct LabelContents {
        static let notANumber = "NaN"
        static let emptyString = ""
        static let defaultOperand = "0"
        static let minusSignSymbole = "-"
        static let pointSymbole = "."
        static let doubleZero = "00"
        static let error = "error"
    }
}
