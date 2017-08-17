// COPY RIGHT 2017 (C) KHUONG PHAM

import Foundation

final class Node<T> {
    var value: T? = nil
    var next: Node? = nil
    weak var previous: Node?
    
    init(value: T? = nil, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    deinit {
        print("Deinit at Value = \(String(describing: value))")
    }
}

final class LinkedList<T> {
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node<T>? {
        return head
    }
    
    var last: Node<T>? {
        return tail
    }
    
    var count: Int {
        if var node = head {
            var c = 1
            while case let next? = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }
    
    func append(_ value: T) {
        let newNode = Node(value: value)
        if let tail = tail {
            newNode.previous = tail
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func insert(value: T, at idx: Int) {
        guard idx >= 0 else { return }
        
        let newNode = Node(value: value)
        let node = index(of: idx)
        let prev = node?.previous
        
        newNode.previous = prev
        newNode.next = node
        prev?.next = newNode
        node?.previous = newNode
        
        if prev == nil {
            head = newNode
        }
    }
    
    func index(of idx: Int) -> Node<T>? {
        if idx >= 0 {
            var node = head
            var i = 0
            while node != nil {
                if i == idx { return node }
                i += 1
                node = node!.next
            }
        }
        return nil
    }
    
    subscript(_ idx: Int) -> T? {
        let node = index(of: idx)
        assert(node != nil)
        return node!.value
    }
    
    func remove(node: Node<T>) -> T? {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        if next == nil {
            tail = prev
        }

        node.previous = nil 
        node.next = nil
        
        return node.value
    }
    
    func remove(at idx: Int) {
        assert(idx > 0)
        guard let node = index(of: idx) else { return }
        remove(node: node)
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
    
    func getAllValues() -> [T] {
        var arr: [T] = []
        var current: Node! = head
        while current != nil && current.value != nil {
            arr.append(current.value!)
            current = current.next
        }
        return arr
    }
    
    func reverse() {
        var node = head
        tail = node
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
}

// TEST
var myList = LinkedList<Int>()
myList.append(1)
myList.append(2)
myList.append(4)
myList.append(5)
myList.insert(value: 3, at: 2)
myList.remove(at: 1)
myList.getAllValues().forEach {
    print($0)
}
myList.reverse()
myList.last?.value
myList.first?.value
print(myList.count)
