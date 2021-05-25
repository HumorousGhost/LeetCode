//
//  TreeNode.swift
//  LeetCode
//
//  Created by UED on 2021/5/25.
//

import Cocoa

public class TreeNode {
    public var val: Int
    
    public var left: TreeNode?
    
    public var right: TreeNode?
    
    public init() {
        self.val = 0
        self.left = nil
        self.right = nil
    }
    
    public init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val;
        self.left = left
        self.right = right
    }
}
