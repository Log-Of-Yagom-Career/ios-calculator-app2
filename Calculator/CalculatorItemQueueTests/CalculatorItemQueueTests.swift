//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by Minseong Kang on 2023/05/30.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
	var sut: MockCalculatorItemQueue<Int>!
	let dummyLinkedList = DummyLinkedList<Int>()
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		sut = MockCalculatorItemQueue(dummyList: dummyLinkedList)
	}
	
	override func tearDownWithError() throws {
		try super.tearDownWithError()
		sut = nil
	}
	
	func tests_Mock_enqueue_호출시_dummyList에_데이터가_쌓인다() {
		// given
		let input = sut
		sut.enqueue(1)
		sut.enqueue(2)
		sut.enqueue(3)
		
		// when
		let result = sut.dummyList
		
		// then
		XCTAssertNotNil(result)
	}
	
	func tests_MockNode의_value값이_비교가_가능하다() {
		// given
		let input = MockNode(value: 1)
		
		// when
		let result = MockNode(value: 2)
		
		// then
		XCTAssertNotEqual(input, result)
	}
}
