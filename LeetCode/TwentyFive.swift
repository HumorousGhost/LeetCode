//
//  TwentyFive.swift
//  LeetCode
//
//  Created by UED on 2021/7/30.
//

import Foundation

class TwentyFive {
    // 257. 二叉树的所有路径
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        
        var paths = [String]()
        
        func constructPaths(_ root: TreeNode?, _ path: String) {
            guard root != nil else {
                return
            }
            var path = path
            path.append("\(root!.val)")
            // 当前节点是叶子节点
            if root?.left == nil && root?.right == nil {
                // 把路径加入到答案中
                paths.append(path)
            }
            // 当前节点不是叶子节点，继续递归遍历
            else {
                path.append("->")
                constructPaths(root?.left, path)
                constructPaths(root?.right, path)
            }
        }
        
        constructPaths(root, "")
        
        return paths
    }
    
    // 258. 各位相加
    func addDigits(_ num: Int) -> Int {
        return (num - 1) % 9 + 1
    }
}
