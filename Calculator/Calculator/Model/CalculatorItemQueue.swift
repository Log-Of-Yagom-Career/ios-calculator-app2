//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/05/30.
//

struct CalculatorItemQueue<T: CalculateItem>: Queueable {
	private var list: LinkedList<T>?
	
	var isEmpty: Bool? {
		guard let isQueueEmpty = list?.isEmpty else { return nil }
		return isQueueEmpty
	}
	
	var front: T? {
		return list?.head?.value
	}
	
	func enqueue(_ value: T) {
		list?.append(value: value)
	}
	
	func dequeue() -> T? {
		return list?.removeFirst()
	}
	
	init(list: LinkedList<T>) {
		self.list = list
	}
}
