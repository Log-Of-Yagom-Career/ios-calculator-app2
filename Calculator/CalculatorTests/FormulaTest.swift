//
//  FormulaTest.swift
//  CalculatorTests
//
//  Created by 박병호 on 2021/11/09.
//

import XCTest
@testable import Calculator

class FormulaTest: XCTestCase {
    
    func test_큐에_1_더하기_2_순서로_enqueue하면_result는_3이다() throws {
        let operators = CalculatorItemQueue<Character>()
        let operands = CalculatorItemQueue<Double>()
        var formula = Formula(operands: operands, operators: operators)
        
        formula.operands.enQueue(1)
        formula.operators.enQueue("+")
        formula.operands.enQueue(2)
        
        try XCTAssertEqual(formula.result(), 3)
    }
    
    func test_큐에_1_더하기_2_나누기_3의_순서로_enqueue하면_result는_1이다() throws {
        let operators = CalculatorItemQueue<Character>()
        let operands = CalculatorItemQueue<Double>()
        var formula = Formula(operands: operands, operators: operators)
        
        formula.operands.enQueue(1)
        formula.operators.enQueue("+")
        formula.operands.enQueue(2)
        formula.operators.enQueue("/")
        formula.operands.enQueue(3)
        
        try XCTAssertEqual(formula.result(), 1)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
