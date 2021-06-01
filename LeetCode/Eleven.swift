//
//  Eleven.swift
//  LeetCode
//
//  Created by UED on 2021/6/1.
//

import Cocoa

class Eleven: NSObject {
    // 110. 平衡二叉树
    func isBalanced(_ root: TreeNode?) -> Bool {
        
        func height(_ root: TreeNode?) -> Int {
            if root == nil {
                return 0
            }
            let leftHeight = height(root?.left)
            let rightHeight = height(root?.right)
            if leftHeight == -1 || rightHeight == -1 || abs(leftHeight - rightHeight) > 1 {
                return -1
            } else {
                return max(leftHeight, rightHeight) + 1
            }
        }
        return height(root) >= 0
    }
}
