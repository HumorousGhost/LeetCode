//
//  NestedIterator.swift
//  LeetCode
//
//  Created by UED on 2021/9/18.
//

import Foundation
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public func isInteger() -> Bool
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     public func getInteger() -> Int
 *
 *     // Set this NestedInteger to hold a single integer.
 *     public func setInteger(value: Int)
 *
 *     // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 *     public func add(elem: NestedInteger)
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     public func getList() -> [NestedInteger]
 * }
 */

// 341. 扁平化嵌套列表迭代器
class NestedIterator {

    var list: [Int] = [Int]()
    
    init(_ nestedList: [NestedInteger]) {
        dfs(nestedList)
    }
    
    private func dfs(_ nestedList: [NestedInteger]) {
        for val in nestedList {
            if val.isInteger() {
                list.append(val.getInteger())
            } else {
                dfs(val.getList())
            }
        }
    }
    
    func next() -> Int {
        
        return list.removeFirst()
    }
    
    func hasNext() -> Bool {
        
        return list.count > 0
    }
     
    class NestedInteger {
        public func isInteger() -> Bool {
            return true
        }
        
        public func getInteger() -> Int {
            return 0
        }
        
        public func setInteger(value: Int) {
            
        }
        
        public func add(elem: NestedInteger) {
            
        }
        
        public func getList() -> [NestedInteger] {
            return []
        }
    }
}

/**
 * Your NestedIterator object will be instantiated and called as such:
 * let obj = NestedIterator(nestedList)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
