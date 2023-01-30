//
//  ExpressionParser.swift
//  Calculator
//
//  Created by kimseongjun on 2023/01/27.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        var operandsQueue = CalculatorItemQueue<Double>()
        var operatorsQueue = CalculatorItemQueue<Operator>()
        
        let separatedOperators = input.compactMap { Operator(rawValue: $0) }
        
        separatedOperators.forEach { `operator` in
            operatorsQueue.enqueue(item: `operator`)
        }
        
        var separatedOperands = componentsByOperators(from: input)
        
        separatedOperands = separatedOperands.map{ if $0.contains("⎼") { return $0.replacingOccurrences(of: "⎼", with: "-")} else {
            return $0
        } }
        separatedOperands.compactMap { Double($0) }.forEach { operand in
            operandsQueue.enqueue(item: operand)
        }
        
        var currentFomula = Formula()
        currentFomula.operands = operandsQueue
        currentFomula.operators = operatorsQueue
        return currentFomula
    }
    
    static private func componentsByOperators(from input: String) -> [String] {
        var numbers: [String] = [input]
        Operator.allCases.forEach { `operator` in
            numbers = numbers.map { $0.split(with: `operator`.rawValue) }.flatMap { $0 }
        }
        return numbers
    }
}
