//: Playground - noun: a place where people can play

import Foundation

final class Node<T: Strideable> {
    var value: T? = nil
    var next: Node? = nil
    
    init(value: T? = nil, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

final class LinkedList<T: Strideable> {
    
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        return tail
    }
    
    func append(_ value: T) {
        // if empty list
        if isEmpty {
            head = Node(value: value)
        } else {
            // Find the last node without a next value
            var lastNode = head!
            while lastNode.next != nil {
                lastNode = lastNode.next!
            }
            // Once found, create a new node and connect the linked list
            let newNode = Node<T>(value: value)
            lastNode.next = newNode
        }
    }
    
    func remove(_ value: T) {
        // if empty list
        guard !isEmpty else { return }
        // Check if the value is at the head
        if value == head!.value {
            head = head!.next
        }
        //Traverse the linked list to see if node is in the linked list
        if head!.value != nil {
            var node = head!
            var previousNode: Node<T>!
            // If value is found, exit the loop
            while node.value != value && node.next != nil {
                previousNode = node
                node = node.next!
            }
            // Once found, connect the previous node to the current node's next
            if node.value == value {
                if node.next != nil {
                    previousNode.next = node.next
                } else {
                    //if at the end, the next is nil 
                    previousNode.next = nil
                }
            }
        }
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
myList.append(100)
myList.append(200)
myList.append(300)
myList.remove(100)
myList.getAllValues().forEach {
    print($0)
}
