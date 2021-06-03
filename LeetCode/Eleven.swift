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
    
    // 113. 路径总和 II
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        
        var ret = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        var path = [Int](repeating: 0, count: 0)
        
        func dfs(_ root: TreeNode?, _ targetSum: Int) {
            if root == nil {
                return
            }
            path.append(root!.val)
            let sum = targetSum - root!.val
            if root?.left == nil && root?.right == nil && sum == 0 {
                ret.append(path)
            }
            dfs(root?.left, sum)
            dfs(root?.right, sum)
            path.removeLast()
        }
        
        dfs(root, targetSum)
        return ret
    }
    
    // 104. 二叉树展开为链表
    func flatten(_ root: TreeNode?) {
        var list = [TreeNode]()
        func preorderTraversal(_ root: TreeNode?) {
            if let tree = root {
                list.append(tree)
                preorderTraversal(tree.left)
                preorderTraversal(tree.right)
            } else {
                return
            }
        }
        preorderTraversal(root)
        if list.count == 0 {
            return
        }
        for i in 1..<list.count {
            let prev = list[i - 1], curr = list[i]
            prev.left = nil
            prev.right = curr
        }
    }
    
    // 115. 不同的子序列
    func numDistinct(_ s: String, _ t: String) -> Int {
        let m = s.count, n = t.count
        if m < n {
            return 0
        }
        let sArr = s.map { String($0) }
        let tArr = t.map { String($0) }
        
        var dp = [[Double]](repeating: [Double](repeating: 0, count: n + 1), count: m + 1)
        for i in 0...m {
            dp[i][n] = 1
        }
        for i in 0..<m {
            let index = m - 1 - i
            let si = sArr[index]
            for j in 0..<n {
                let jndex = n - 1 - j
                let tj = tArr[jndex]
                if si == tj {
                    dp[index][jndex] = dp[index + 1][jndex + 1] + dp[index + 1][jndex]
                } else {
                    dp[index][jndex] = dp[index + 1][jndex]
                }
            }
        }
        return Int(dp[0][0])
    }
    
    // 116. 填充每个节点的下一个右侧节点指针
    func connect(_ root: Node?) -> Node? {
        if root == nil {
            return root
        }
        
        var queue = [Node?]()
        queue.append(root)
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let node = queue.removeFirst()
                if i < size - 1 {
                    node?.next = queue.first!
                }
                if node?.left != nil {
                    queue.append(node?.left)
                }
                if node?.right != nil {
                    queue.append(node?.right)
                }
            }
        }
        return root
    }
    
    // 117. 填充每个节点的下一个右侧节点指针 II
    func connectNode(_ root: Node?) -> Node? {
        if root == nil {
            return root
        }
        
        var queue = [Node?]()
        queue.append(root)
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let node = queue.removeFirst()
                if i < size - 1 {
                    node?.next = queue.first!
                }
                if node?.left != nil {
                    queue.append(node?.left)
                }
                if node?.right != nil {
                    queue.append(node?.right)
                }
            }
        }
        return root
    }
    
    // 118. 杨辉三角
    func generate(_ numRows: Int) -> [[Int]] {
        if numRows == 0 {
            return []
        }
        
        var res = [[Int]]()
        res.append([1])
        for i in 1..<numRows {
            var level = [Int]()
            level.append(1)
            let flows = res[i - 1]
            for j in 0..<flows.count {
                if flows.count - 2 >= j {
                    level.append(flows[j] + flows[j + 1])
                }
            }
            level.append(1)
            res.append(level)
        }
        return res
    }
}
