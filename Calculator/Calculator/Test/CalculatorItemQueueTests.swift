//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by kokkilE on 2023/01/25.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<String>?

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
    }

    func test_enqueueCalculateItems_2회_호출시_count는_2이다() {
        // given
        sut?.enqueueCalculateItems(Node("10"))
        sut?.enqueueCalculateItems(Node("20"))
        let expectation = 2

        // when
        let result = sut?.calculateItemsCount

        // then
        XCTAssertEqual(result, expectation)
    }

    func test_calculateItems가_비어있을경우_dequeueCalculateItems_호출시_nil_반환한다() {
        // given
        let input = sut?.dequeueCalculateItems()

        // when / then
        XCTAssertEqual(input, nil)
    }

    func test_dequeueCalculateItems_호출시_먼저_enqueue된_데이터를_반환한다() {
        // given
        let input1 = Node("10")
        let input2 = Node("20")
        sut?.enqueueCalculateItems(input1)
        sut?.enqueueCalculateItems(input2)
        let expectation = input1

        // when
        let result = sut?.dequeueCalculateItems()

        // when / then
        XCTAssertEqual(result, expectation)
    }

    func test_dequeueCalculateItems_호출시_count가_감소한다() {
        // given
        let input1 = Node("10")
        let input2 = Node("20")
        sut?.enqueueCalculateItems(input1)
        sut?.enqueueCalculateItems(input2)
        var expectation = 2

        // when
        var result = sut?.calculateItemsCount

        // then
        XCTAssertEqual(result, expectation)

        // given
        expectation = 1

        // when
        _ = sut?.dequeueCalculateItems()
        result = sut?.calculateItemsCount

        // then
        XCTAssertEqual(result, expectation)
    }
}