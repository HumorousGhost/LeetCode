//
//  NestedInteger.swift
//  LeetCode
//
//  Created by UED on 2021/11/10.
//

import Foundation

// This is the interface that allows for creating nested lists.
// You should not implement it, or speculate about its implementation
class NestedInteger {
    
    // Return true if this NestedInteger holds a single integer, ranther than a nested list.
    public func isInteger() -> Bool {
        return true
    }
    
    // Return the single integer that this NedtedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    public func getInteger() -> Int {
        return 0
    }
    
    // Set this NestedInteger to hold a single integer.
    public func setInteger(_ value: Int) {
        
    }
    
    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    public func add(_ elem: NestedInteger) {
        
    }
    
    // Return the nested list that this NestedInteger holds, if it holds a nested list
    // The result is undefined if this NestedInteger holds a single integer
    public func getList() -> [NestedInteger] {
        return []
    }
}
