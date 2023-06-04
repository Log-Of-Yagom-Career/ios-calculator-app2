//
//  ExpressionParser.swift
//  Calculator
//
//  Created by Hyungmin Lee on 2023/06/02.
//

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        let operatorComponents = input.compactMap { Operator(rawValue: $0) }
        let operandComponents = componentsByOperators(from: input).compactMap { return Double($0) }
        var operatorQueue = CalculatorItemQueue<Operator>()
        var operandQueue = CalculatorItemQueue<Double>()
        
        operatorComponents.forEach{ operatorQueue.enqueue(element: $0) }
        operandComponents.forEach { operandQueue.enqueue(element: $0) }
        let formula = Formula(operands: operandQueue, operators: operatorQueue)
        
        return formula
    }
    
    static func componentsByOperators(from input: String) -> [String] {
        var remainFormula: String = input
        var operandComponents = [String]()
        
        while true {
            let splitFormulaByFirstOperator: [String] = splitRemainStringByFirstOperator(remainFormula)
            
            if isSplitByFirstOperator(splitFormulaByFirstOperator) == false {
                operandComponents.append(remainFormula)
                break
            }
            
            guard let operand = splitFormulaByFirstOperator.first,
                  let remainString = splitFormulaByFirstOperator.last else { break }
            
            operandComponents.append(operand)
            remainFormula = remainString
        }
        
        return operandComponents
//      return input.components(separatedBy: ["+", "−", "*", "/"])
    }
}

extension ExpressionParser {
    static func splitRemainStringByFirstOperator(_ remainString: String) -> [String] {
        var splitListByFirstOperator: [String] = []
        
        for character in remainString {
            if let `operator` = Operator(rawValue: character) {
                splitListByFirstOperator = remainString.split(with: `operator`.rawValue)
                break
            }
        }
        
        return splitListByFirstOperator
    }
    
    static func isSplitByFirstOperator(_ splitListByFirstOperator: [String]) -> Bool {
        return splitListByFirstOperator.count != 0
    }
}
