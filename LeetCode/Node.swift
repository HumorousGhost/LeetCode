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
    public var neighbors: [Node?]
    public init(_ val: Int, _ left: Node? = nil, _ right: Node? = nil) {
        self.val = val
        self.left = left
        self.right = right
        self.next = nil
        self.neighbors = []
    }
}
