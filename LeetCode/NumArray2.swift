//
//  NumArray2.swift
//  LeetCode
//
//  Created by UED on 2021/8/24.
//

import Foundation

// 307. 区域和检索 - 数组可修改
class NumArray2 {
    
    class Node {
        open var left: Node?
        open var right: Node?
        open var leftIndex: Int
        open var rightIndex: Int
        open var sum: Int
        
        init(_ left: Node?, _ right: Node?, _ leftIndex: Int, _ rightIndex: Int, _ sum: Int) {
            self.left = left
            self.right = right
            self.leftIndex = leftIndex
            self.rightIndex = rightIndex
            self.sum = sum
        }
    }

    let numArray : [Int]
        
    var root : Node? = nil
        
    init(_ nums: [Int]) {
        self.numArray = nums
        if (nums.count > 0) {
            self.root = buildSegmentTree(start: nums.startIndex, end: nums.endIndex - 1)
        }
    }
        
    func buildSegmentTree(start: Int, end: Int) -> Node {
        if (start == end) {
            return Node.init(nil, nil, start, end, numArray[start])
        }
        let mid = start + (end - start) / 2
        let left = buildSegmentTree(start: start, end: mid)
        let right = buildSegmentTree(start: mid + 1, end: end)
        return Node(left, right, start, end, left.sum + right.sum)
    }
        
    func sumRange(_ left: Int, _ right: Int) -> Int  {
        return queryRange(left, right, self.root!)
    }
        
    func update(_ index: Int, _ val: Int) {
        update(index, val, root!)
    }
        
    private func update(_ index: Int, _ val: Int, _ node: Node) {
        if (node.leftIndex == index && node.rightIndex == index) {
            node.sum = val;
            return;
        }
        let mid = node.leftIndex + (node.rightIndex - node.leftIndex) / 2
        if (index <= mid) {
            update(index, val, node.left!)
        }
        if (index > mid) {
            update(index, val, node.right!)
        }
        node.sum = node.left!.sum + node.right!.sum
        return;
    }
    
    private func queryRange(_ start: Int, _ end: Int, _ node: Node) -> Int {
        if (start == node.leftIndex &&  end == node.rightIndex) {
            return node.sum;
        }
        let mid = node.leftIndex + (node.rightIndex - node.leftIndex) / 2
        if (end <= mid) {
            return queryRange(start, end, node.left!)
        }
        if (start > mid) {
            return queryRange(start, end, node.right!)
        }
        return queryRange(start, mid, node.left!) + queryRange(mid + 1, end, node.right!)
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * let obj = NumArray(nums)
 * obj.update(index, val)
 * let ret_2: Int = obj.sumRange(left, right)
 */
