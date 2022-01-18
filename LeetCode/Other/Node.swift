//
//  Node.swift
//  LeetCode
//
//  Created by UED on 2021/6/3.
//

import Cocoa

public class Node {
    
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public var neighbors: [Node?] // 图表
    public var random: Node? // 随机指针
    public var children: [Node] // 429. N 叉树的层序遍历
    
    public init(_ val: Int, _ left: Node? = nil, _ right: Node? = nil) {
        self.val = val
        self.left = left
        self.right = right
        self.next = nil
        self.neighbors = []
        self.random = nil
        self.children = []
    }
}
