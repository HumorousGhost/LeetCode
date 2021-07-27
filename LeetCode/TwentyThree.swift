//
//  TwentyThree.swift
//  LeetCode
//
//  Created by UED on 2021/7/26.
//

import Foundation

class TwentyThree {
    // 230. 二叉搜索树中第K小的元素
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var nums = [Int]()
        
        func tree(_ root: TreeNode?) {
            guard root != nil else {
                return
            }
            tree(root?.left)
            nums.append(root!.val)
            tree(root?.right)
        }
        
        tree(root)
        
        return nums[k - 1]
    }
    
    // 231. 2 的幂
    func isPowerOfTwo(_ n: Int) -> Bool {
        return n > 0 && (n & -n) == n
    }
}
