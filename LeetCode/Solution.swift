//
//  Solution.swift
//  LeetCode
//
//  Created by UED on 2021/11/8.
//

import Foundation

// 382. 链表随机节点
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

class Solution {

    var list: [ListNode]
    
    init(_ head: ListNode?) {
        list = [ListNode]()
        var current = head
        while current != nil {
            list.append(current!)
            current = current?.next
        }
    }
    
    func getRandom() -> Int {
        let current = list[Int.random(in: 0..<list.count)]
        return current.val
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(head)
 * let ret_1: Int = obj.getRandom()
 */
