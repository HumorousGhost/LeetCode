//
//  MyStack.swift
//  LeetCode
//
//  Created by UED on 2021/7/22.
//

import Foundation

// 225. 用队列实现栈
class MyStack {
    
    var stack: [Int]
    
    /**
     * Initialize your data structure here.
     */
    init() {
        stack = [Int]()
    }
    
    /**
     Push element x onto stack.
     */
    func push(_ x: Int) {
        stack.append(x)
    }
    
    /**
     Removes the element on top of stack and returns that element.
     */
    func pop() -> Int {
        return stack.removeLast()
    }
    
    /**
     Get the top element.
     */
    func top() -> Int {
        return stack.last ?? 0
    }
    
    /**
     Returns whether the stack is empty.
     */
    func empty() -> Bool {
        return stack.isEmpty
    }
}

/**
 * Your MyStack object will be instantiated and called as such:
 * let obj = MyStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Bool = obj.empty()
 */
