//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Rowan on 2023/01/24.
//

struct CalculatorItemQueue<Element: CalculateItem> {
    
    var queue: LinkedList<Element>
    
    mutating func enqueue(_ element: Element) {
        queue.appendLast(element)
    }
    
    mutating func dequeue() -> Element? {
        guard let element = queue.removeFirst() else { return nil }
        
        return element
    }
    
    mutating func removeAll() {
        queue.removeAll()
    }
}
