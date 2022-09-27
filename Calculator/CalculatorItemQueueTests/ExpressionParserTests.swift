//
//  ExpressionParserTests.swift
//  Created by 미니.
//
import XCTest
@testable import Calculator

final class ExpressionParserTests: XCTestCase {
    func test_연산자와피연산자의문자가모드정상적인경우결과가예측치와동일한지() {
        // driven
        let input: String = "10+9*8-7/6"
        // when
        let form: Formula = ExpressionParser.parse(from: input)
        let result = form.result()
        
        // then
        XCTAssertEqual(try result.get(), 24.166666666666667)
    }
    
    func test_다른연산자와마이너스연산자가붙어서나올때결과가예측치와동일한가() {
        // driven
        let input: String = "10+9*8-7*-6"
        
        // when
        let form: Formula = ExpressionParser.parse(from: input)
        let result = form.result()
        
        // then
        XCTAssertEqual(try result.get(), -870)
    }
    
    func test_첫번째피연산자에마이너스가붙은경우결과가예측치와동일한가() {
        // driven
        let input: String = "-10+9*8-76"
        // when
        let form: Formula = ExpressionParser.parse(from: input)
        let result = form.result()
        
        // then
        XCTAssertEqual(try result.get(), -84)
    }
}

