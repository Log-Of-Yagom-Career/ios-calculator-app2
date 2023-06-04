//
//  Formula.swift
//  Calculator
//
//  Created by Hyungmin Lee on 2023/06/02.
//

enum CaculateError: Swift.Error {
    case notHaveOperands
    case notANumber
}

struct Formula {
    var operands: CalculatorItemQueue<Double>
    var operators: CalculatorItemQueue<Operator>
    
    mutating func result() -> Double {
        var result = 0.0
        
        do {
            result = try calculateOperands()
        } catch {
            
        }
        
        return result
    }
    
    mutating func calculateOperands() throws -> Double {
        guard var result = operands.dequeue() else { throw CaculateError.notHaveOperands }
        
        while operators.isEmpty() == false {
            guard let operand = operands.dequeue() else { break }
            guard let `operator` = operators.dequeue() else { break }
            
            result = `operator`.calculate(lhs: result, rhs: operand)
        }

        return result
    }
}
