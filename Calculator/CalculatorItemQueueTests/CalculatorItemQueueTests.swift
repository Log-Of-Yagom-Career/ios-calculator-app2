//  CalculatorItemQueueTests - CalculatorItemQueueTests.swift
//  created by vetto on 2023/01/25

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<String>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue<String>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: - isEmpty computed property test
    func test_head가_nil일_때_isQueueEmpty호출하면_true이다() {
    }
    
    func test_CalculatorItemQueue에_Node를_추가하고_isQueueEmpty호출하면_false이다() {
     
    }
    
    // MARK: - enqueue method test
    func test_빈_큐에_enqueue하면_head에_들어간다() {
     
    }
    
    func test_빈_큐에_enqueue하면_head랑_tail에_들어간다() {
    
    }
    
    func test_큐에_두번_enqueue해도_head는_바뀌지_않는다() {
    
    }
    
    func test_큐에_enqueue를_여러변하면_tail에_추가된다() {
    
    }
    
    // MARK: - dequeue method test
    func test_빈_큐에_dequeue하면_nil이_반환되면_true() {
       
    }
    
    func test_빈_큐의_하나의_node를_넣고_dequeue를_한번_하면_head의_data값이_반환된다() {
    
    }
    
    func test_빈_큐의_하나의_node를_넣고_dequeue를_한번_하면_head의_값이_nil이_된다() {
        
    }
    
    func test_빈_큐의_두개의_node를_넣고_dequeue를_한번_하면_head의_값이_다음값으로_바뀐다() {
        
    }
    
    func test_빈_큐의_두개의_node를_넣고_dequeue를_두번_하면_head의_값이_nil이된다() {
        
    }
    
    func test_빈_큐의_두개의_node를_넣고_dequeue를_두번_하면_tail의_값이_nil이된다() {
        
    }
    
    // MARK: - clear method test
    func test_큐에_두개의_노드를_넣고_clear메소드를_호출하면_head가_nil이_된다() {
        
    }
    
    func test_큐에_두개의_노드를_넣고_clear메소드를_호출하면_tail가_nil이_된다() {
        
    }
    func test_큐에_세개의_노드를_넣고_clear메소드를_호출하면_중간의_노드가_nil이_된다() {
        
    }
}
