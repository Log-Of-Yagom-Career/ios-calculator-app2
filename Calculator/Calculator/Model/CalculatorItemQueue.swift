//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by 맹선아 on 2022/09/19.
//

import Foundation

struct CalculatorItemQueue <T> : CalculateItem {
    var itemQueue: LinkedList<T> = LinkedList()
    
    mutating func enqueue(_ data: T) {
        self.itemQueue.append(data)
    }
    
    mutating func dequeue() -> Node<T>? {
        let firstItem = self.itemQueue.removeFirst()
        return firstItem
    }

    mutating func clear() {
        self.itemQueue.head = nil
    }
}
