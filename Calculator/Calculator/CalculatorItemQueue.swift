//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Gundy on 2022/09/19.
//

struct CalculatorItemQueue<T>: CalculateItem {
    var data: [T] = []
    var count: Int {
        get {
            return data.count
        }
    }
    
    init() {}
    
    mutating func enqueue(_ element: T) {
        data.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard let element = data.first else {
            return nil
        }
        data.removeFirst()
        return element
    }
    
    func peek() -> T? {
        guard let element = data.first else {
            return nil
        }
        return element
    }
    
    mutating func clear() {
        data = []
    }
    
    func isEmpty() -> Bool {
        return false
    }
}
