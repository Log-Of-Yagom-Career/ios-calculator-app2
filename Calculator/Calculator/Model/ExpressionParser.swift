//
//  ExpressionParser.swift
//  Calculator
//
//  Created by 조민호 on 2022/03/18.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        let operands = makeOperandsQueue(from: input)
        let operators = makeOperatorsQueue(from: input)

        return Formula(operands: operands, operators: operators)
    }
    
    private static func componentsByOperators(from input: String) -> [String] {
        input.split(with: " ")
            .compactMap { string in
                Double(string)
            }
            .map { double in
                String(double)
            }
    }
    
    private static func componentsByOperands(from input: String) -> [Operator] {
        let operatorTypes = Operator
            .allCases
            .map { type in
                String(type.rawValue)
            }
        
        return input.split(with: " ")
            .filter { string in
                operatorTypes.contains(string)
            }
            .compactMap { string in
                Operator(rawValue: Character(string))
            }
    }
    
    private static func makeOperandsQueue(from input: String) -> CalculatorItemQueue<Double> {
        var operands = CalculatorItemQueue<Double>()
        
        componentsByOperators(from: input)
            .compactMap { string in
                Double(string)
            }
            .forEach { operand in
                operands.enqueue(operand)
            }
        
        return operands
    }
    
    private static func makeOperatorsQueue(from input: String) -> CalculatorItemQueue<Operator> {
        var operators = CalculatorItemQueue<Operator>()
        
        componentsByOperands(from: input)
            .forEach { `operator` in
                operators.enqueue(`operator`)
            }
        
        return operators
    }
}
