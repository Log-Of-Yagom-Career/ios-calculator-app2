//
//  LinkedList.swift
//  Calculator
//
//  Created by NAMU on 2022/05/17.
//

struct LinkedList<T> {
    var head: Node<T>?
    
    mutating func append(data: T) {
        if head == nil {
            head = Node(data: data)
            return
        }
        
        var node = head
        
        while node?.next != nil {
            node = head?.next
        }
        node?.next = Node(data: data)
    }
    
    mutating func takeOutFirst() -> T? {
        if head != nil {
            return head?.data
        }
        return nil
    }
    
    func isEmpty() -> Bool {
        if head != nil {
            return true
        }
        return false
    }
}
