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
    
    // 111. 二叉树的最小深度
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        if root?.left == nil && root?.right == nil {
            return 1
        }
        
        var minOrder = Int.max
        if root?.left != nil {
            minOrder = min(minDepth(root?.left), minOrder)
        }
        if root?.right != nil {
            minOrder = min(minDepth(root?.right), minOrder)
        }
        
        return minOrder + 1
    }
    
    // 112. 路径总和
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        
        if root == nil {
            return false
        }
        
        if root?.left == nil && root?.right == nil {
            return targetSum == root!.val
        }
        
        let target = targetSum - root!.val
        
        return hasPathSum(root?.left, target) || hasPathSum(root?.right, target)
    }
}
