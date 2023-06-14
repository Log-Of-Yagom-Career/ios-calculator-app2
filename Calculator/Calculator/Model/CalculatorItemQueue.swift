//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by mint, Whales on 2023/05/30.
//

struct CalculatorItemQueue<Element: CalculateItem>: Queueable {
    private(set) var queue: LinkedList = LinkedList<Element>()
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    var firstData: Element? {
        return queue.headData
    }
    
    var lastData: Element? {
        return queue.tailData
    }
    
    mutating func enqueue(_ element: Element) {
        queue.append(data: element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        return queue.removeFirst()
    }
    
    mutating func clearQueue() {
        queue.removeAll()
    }
}
