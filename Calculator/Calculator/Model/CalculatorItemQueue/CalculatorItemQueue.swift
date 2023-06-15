//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Dasan on 2023/05/30.
//

protocol Queueable {
    associatedtype T
    
    mutating func enqueue(_ data: T)
    mutating func dequeue() -> T?
}

struct CalculatorItemQueue<T: CalculateItem>: Queueable {
    private var queue: LinkedList<T> = LinkedList()
    
    mutating func enqueue(_ data: T) {
        queue.append(data)
    }
    
    mutating func dequeue() -> T? {
        return queue.removeFirst()
    }
}
