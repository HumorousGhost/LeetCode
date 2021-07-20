//
//  ListNode.swift
//  LeetCode
//
//  Created by UED on 2021/4/22.
//

import Cocoa

public class ListNode {
    
    public var val: Int
    public var next: ListNode?
    
    public init() {
        self.val = 0;
        self.next = nil;
    }
    
    public init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val;
        self.next = next;
    }
}
