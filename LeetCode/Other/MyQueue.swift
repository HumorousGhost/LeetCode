//
//  MyQueue.swift
//  LeetCode
//
//  Created by UED on 2021/7/27.
//

import Foundation

// 232. 用栈实现队列
class MyQueue {
    
    private var queue: [Int]
    
    /** Initialize your data structure here. */
    init() {
        queue = [Int]()
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        queue.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        return queue.removeFirst()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        return queue.first ?? 0
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return queue.isEmpty
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */
