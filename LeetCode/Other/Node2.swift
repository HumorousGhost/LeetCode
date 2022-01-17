//
//  Node2.swift
//  LeetCode
//
//  Created by UED on 2022/1/17.
//

import Foundation

// 427. 建立四叉树
public class Node2 {
    public var val: Bool
    public var isLeaf: Bool
    public var topLeft: Node2?
    public var topRight: Node2?
    public var bottomLeft: Node2?
    public var bottomRight: Node2?
    public init(_ val: Bool, _ isLeaf: Bool) {
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = nil
        self.topRight = nil
        self.bottomLeft = nil
        self.bottomRight = nil
    }
}
