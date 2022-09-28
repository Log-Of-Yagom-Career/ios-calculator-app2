//
//  ExpressionParser.swift
//  Calculator
//
//  Created by Mangdi on 2022/09/22.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        let numberArray = componentsByOperators(from: input).compactMap { Double($0) }
        let operands = CalculatorItemQueue<Double>()
        let operators = CalculatorItemQueue<Operator>()
        var formula = Formula(operands: operands, operators: operators)
        
        for num in numberArray {
            formula.operands?.enqueue(num)
        }
        
        let allOperators = Operator.allCases.map { $0.rawValue }
        let operatorArray = input.filter { allOperators.contains($0) }.map { Operator.init(rawValue: $0) }
        
        for op in operatorArray {
            if let op = op {
                formula.operators?.enqueue(op)
            }
        }

        return formula
    }
    
    static private func componentsByOperators(from input: String) -> [String] {
        let operators = Operator.allCases.reduce("") { $0 + String($1.rawValue) }
        let separators = CharacterSet(charactersIn: operators)
        let operandsArray = input.components(separatedBy: separators)
        return operandsArray
    }
}
