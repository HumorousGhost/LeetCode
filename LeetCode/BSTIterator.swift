//
//  BSTIterator.swift
//  LeetCode
//
//  Created by UED on 2021/6/29.
//

import Foundation

// 173. 二叉搜索树迭代器
class BSTIterator {
    
    private var index: Int
    private var list: [Int]
    
    init(_ root: TreeNode?) {
        self.index = -1
        self.list = [Int]()
        inorderTraversal(root)
    }
    
    func next() -> Int {
        self.index += 1
        return self.list[self.index]
    }
    
    func hasNext() -> Bool {
        return self.index + 1 < self.list.count
    }
    
    private func inorderTraversal(_ root: TreeNode?) {
        if root == nil {
            return
        }
        inorderTraversal(root?.left)
        self.list.append(root!.val)
        inorderTraversal(root?.right)
    }
}
