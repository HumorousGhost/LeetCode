//
//  MinStack.swift
//  LeetCode
//
//  Created by UED on 2021/6/23.
//

import Foundation

// 155. 最小栈
class MinStack {
    /**
     initialize your data structure here.
     */
    private var stack: [Int]
    private var minStack: [Int]
    
    init() {
        self.stack = [Int]()
        self.minStack = [Int]()
        self.minStack.append(Int.max)
    }
    
    func push(_ val: Int) {
        self.stack.append(val)
        minStack.append(min(minStack.last!, val))
    }
    
    func pop() {
        self.stack.removeLast()
        self.minStack.removeLast()
    }
    
    func top() -> Int {
        return self.stack.last ?? 0
    }
    
    func getMin() -> Int {
        return self.minStack.last ?? 0
    }
}
