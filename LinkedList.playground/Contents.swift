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
    
    func index(of idx: Int) -> Node<T>? {
        if idx >= 0 {
            var node = head
            var i = idx
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil
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
}

// TEST
var myList = LinkedList<Int>()
myList.append(1)
myList.append(2)
myList.append(3)
let node = myList.index(of: 2)!
myList.remove(node: node)
myList.getAllValues().forEach {
    print($0)
}
