//
//  DoublyLinkedListTests.swift
//  DoublyLinkedListTests
//
//  Created by Derrick kim on 2022/05/17.
//

import XCTest
@testable import Calculator

class DoublyLinkedListTests: XCTestCase {
    var sut: DoublyLinkedList<Double>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DoublyLinkedList()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
 
    func test_양방향_연결리스트에_값을_추가할_수_있다() {
        // given
        let number = 2.2
        // when
        sut.append(number)
        // then
        let result = sut.isEmpty
        
        XCTAssertFalse(result)
    }
    
    func test_양방향_연결리스트의_첫_번째_값을_구할수_있다() {
        // given
        let firstValue = 3.2
        let secondValue = 2.0
        let expectation = 3.2
        // when
        sut.append(firstValue)
        sut.append(secondValue)
        // then
        let result = sut.first?.value
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_양방향_연결리스트의_첫_번째_값을_제거할_수_있다() {
        // given
        let array = [3.2, 2.0, 3.0, 4.0]

        let expectation = 2.0
        // when
        array.forEach { value in
            sut.append(value)
        }
        
        sut.remove(sut.first!)
        let result = sut.first?.value
        
        // then
        XCTAssertEqual(result, expectation)
    }
 
    func test_양방향_연결리스트의_저장된_데이터중_2번째_값을_반환한다() {
        // given
        let array = [3.2, 2.0, 3.0, 4.0, 2.0,
                     0.3, 0, 2.0, 3.0, 4.0]
        let expectation: Double = 2.0
        // when
        array.forEach { value in
            sut.append(value)
        }
        
        let result = sut[1]
        // then
        XCTAssertEqual(result, expectation)
    }
}
