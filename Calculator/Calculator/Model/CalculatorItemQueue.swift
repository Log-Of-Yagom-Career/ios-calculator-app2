protocol CalculateItem { }

struct CalculatorItemQueue<T: CalculateItem> {
    private(set) var head: Node<T>? = nil
    private(set) var tail: Node<T>? = nil
    private(set) var count: Int = 0
    var isEmpty: Bool {
        return count == 0
    }
    
    mutating func enqueue(_ element: T) {
        let node: Node<T> = Node<T>(data: element)
        if isEmpty {
            head = node
        } else if count == 1 {
            head?.next = node
        } else {
            tail?.next = node
        }
        tail = node
        self.count += 1
    }
    
    mutating func dequeue() -> T? {
        guard let currentHead: Node<T> = self.head else {
            return nil
        }
        let nextHead: Node<T> = currentHead.next
        self.head = nil
        self.head = nextHead
        self.count -= 1
        return currentHead.data
    }
    
    func peek() -> T? {
        return head?.data
    }
    
    mutating func clear() {
        self.head = nil
        self.tail = nil
        self.count = 0
    }
}

class Node<T> {
    var next: Node<T>?
    var data: T
    
    init(data: T) {
        self.data = data
    }
}
