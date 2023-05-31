//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by Minseong Kang on 2023/05/30.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
	var sut: CalculatorItemQueue!
	
    override func setUpWithError() throws {
		try super.setUpWithError()
		sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
		try super.tearDownWithError()
		sut = nil
    }
	
	func tests_배열에_값이_들어간다() {
		// given
		let input: () = sut.enqueue(1)
		
		// when
		let result: () = input
		
		// then
		XCTAssertNotNil(result)
	}
	
	func tests_배열에서_값이_빠진다() {
		// given
		let input: () = sut.enqueue(1)
		
		// when
		let result: () = sut.dequeue(1)
		
		// then
		XCTAssertNil(result)
	}
}
