//
//  FormulaTests.swift
//  FormulaTests
//
//  Created by 김인호 on 2022/09/22.
//

import XCTest
@testable import Calculator

class FormulaTests: XCTestCase {
    var sut: Formula!
    let operandsQueue = CalculatorItemQueue<Double>()
    let operatorsQueue = CalculatorItemQueue<Operator>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Formula(operands: operandsQueue, operators: operatorsQueue)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_result실행시_피연산자큐가비어있으면_0을리턴하는가() {
        //given
        
        //when
        let result = try? sut.result()
        
        //then
        XCTAssertEqual(0, result)
    }
    
    func test_result실행시_두번째연산자가없으면_첫번째연산자를리턴하는가() {
        //given
        operandsQueue.enqueue(element: 3)
        operatorsQueue.enqueue(element: Operator.add)
        operandsQueue.enqueue(element: 6)
        operatorsQueue.enqueue(element: Operator.divide)
        
        //when
        let result = try? sut.result()
        
        //then
        XCTAssertEqual(9, result)
    }
    
    func test_result실행시_연산자가없으면_에러를throw하는가() {
        //given
        operandsQueue.enqueue(element: 3)
        operandsQueue.enqueue(element: 5)
        
        //when
        let result = try? sut.result()
        
        //then
        XCTAssertNil(result)
    }
    
    func test_result실행시_조건이모충족되면_연산이제대로작동하는가() {
        //given
        operandsQueue.enqueue(element: 6)
        operatorsQueue.enqueue(element: Operator.divide)
        operandsQueue.enqueue(element: -3)
        operatorsQueue.enqueue(element: Operator.add)
        operandsQueue.enqueue(element: 5)
        
        //when
        let result = try? sut.result()
        
        //then
        XCTAssertEqual(6.0 / -3.0 + 5.0, result)
    }
    
    func test_result실행시_0으로나누면_에러를throw하는가() {
        //given
        operandsQueue.enqueue(element: 10)
        operatorsQueue.enqueue(element: Operator.divide)
        operandsQueue.enqueue(element: 0)
        
        //when
        let result = try? sut.result()
        
        //then
        XCTAssertNil(result)
    }
}