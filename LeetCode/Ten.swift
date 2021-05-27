//
//  Ten.swift
//  LeetCode
//
//  Created by UED on 2021/5/27.
//

import Cocoa

class Ten: NSObject {
    // 100. 相同的树
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        } else if (p == nil || q == nil) {
            return false
        } else if p?.val != q?.val {
            return false
        } else {
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
    }
    
    // 101. 对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        func check(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
            if p == nil && q == nil {
                return true
            } else if p == nil || q == nil {
                return false
            } else {
                return p!.val == q?.val && check(p?.left, q?.right) && check(p?.right, q?.left)
            }
        }
        
        return check(root, root)
    }
}
