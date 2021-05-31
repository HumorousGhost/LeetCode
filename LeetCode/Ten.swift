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
    
    // 102. 二叉树的层序遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        if root == nil {
            return ret
        }
        
        var queue = [TreeNode?](repeating: nil, count: 0)
        queue.append(root)
        while !queue.isEmpty {
            var level = [Int](repeating: 0, count: 0)
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                level.append(node!.val)
                if node?.left != nil {
                    queue.append(node?.left)
                }
                if node?.right != nil {
                    queue.append(node?.right)
                }
            }
            ret.append(level)
        }
        return ret
    }
    
    // 103. 二叉树的锯齿形层序遍历
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        if root == nil {
            return ret
        }
        
        var queue = [TreeNode?](repeating: nil, count: 0)
        queue.append(root)
        var order = 0
        while !queue.isEmpty {
            var level = [Int](repeating: 0, count: 0)
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                if order % 2 == 0 {
                    level.append(node!.val)
                } else {
                    level.insert(node!.val, at: 0)
                }
                if node?.left != nil {
                    queue.append(node?.left)
                }
                if node?.right != nil {
                    queue.append(node?.right)
                }
            }
            ret.append(level)
            order += 1
        }
        return ret
    }
    
    // 104. 二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        var ret = 1
        func maxTree(_ root: TreeNode?, _ order: Int) {
            if root == nil {
                return
            }
            
            ret = max(ret, order)
            
            if root?.left != nil {
                maxTree(root?.left, order + 1)
            }
            if root?.right != nil {
                maxTree(root?.right, order + 1)
            }
        }
        
        maxTree(root, 1)
        
        return ret
    }
    
    // 105. 从前序与中序遍历序列构造二叉树
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        
        var indexMap = [Int : Int]()
        
        // 构造哈希映射，帮助我们快速定位根节点
        for (index, value) in inorder.enumerated() {
            indexMap[value] = index
        }
        
        func myBuildTree(_ preorder: [Int], _ inorder: [Int], _ preorderLeft: Int, _ preorderRight: Int, _ inorderLeft: Int, _ inorderRight: Int) -> TreeNode? {
            if preorderLeft > preorderRight {
                return nil
            }
            
            // 前序遍历中的第一个节点就是根节点
            let preorderRoot = preorderLeft
            // 在中序遍历中定位根节点
            let inorderRoot = indexMap[preorder[preorderRoot]]!
            
            // 先把根节点建立出来
            let root = TreeNode.init(preorder[preorderRoot])
            // 得到左子树中的节点数目
            let sizeLeftSubtree = inorderRoot - inorderLeft
            
            // 递归的构造左子树，并连接到根节点
            // 先序遍历中 [从 左边界 + 1 开始的 sizeLeftSubtree] 个元素就对应了中序遍历中 [从 左边界 开始到 根节点定位 - 1] 的元素
            root.left = myBuildTree(preorder, inorder, preorderLeft + 1, preorderLeft + sizeLeftSubtree, inorderLeft, inorderRoot - 1)
            
            // 递归的构造右子树，并连接到根节点
            // 先序遍历中 [从 左边界 + 1 + 左子树节点数目 开始到 右边界] 的元素就对应了中序遍历中 [从 根节点定位 + 1 到 右边界] 的元素
            root.right = myBuildTree(preorder, inorder, preorderLeft + sizeLeftSubtree + 1, preorderRight, inorderRoot + 1, inorderRight)
            return root
        }
        
        let n = preorder.count
        
        return myBuildTree(preorder, inorder, 0, n - 1, 0, n - 1)
    }
    
    // 106. 从中序与后序遍历序列构造二叉树
    func buildTreePostorder(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        
        var idxMap = [Int: Int]()
        for (index, value) in inorder.enumerated() {
            idxMap[value] = index
        }
        var postIdx = postorder.count - 1
        
        func helper(_ inLeft: Int, _ inRight: Int) -> TreeNode? {
            // 如果这里没有节点构造二叉树了，就结束
            if inLeft > inRight {
                return nil
            }
            
            // 选择 postIdx 位置的元素作为当前子树根节点
            let rootVal = postorder[postIdx]
            let root = TreeNode.init(rootVal)
            
            // 根据 root 所在位置分成左右两棵子树
            let index = idxMap[rootVal]!
            
            // 下标减一
            postIdx -= 1
            // 构造右子树
            root.right = helper(index + 1, inRight)
            // 构造左子树
            root.left = helper(inLeft, index - 1)
            return root
        }
        
        return helper(0, postIdx)
    }
    
    // 107. 二叉树的层序遍历 II
    func levelOrderBottom (_ root: TreeNode?) -> [[Int]] {
        var ans = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        if root == nil {
            return ans
        }
        
        var queue = [TreeNode?](repeating: nil, count: 0)
        queue.append(root)
        while !queue.isEmpty {
            var level = [Int](repeating: 0, count: 0)
            let count = queue.count
            for _ in 0..<count {
                let tree = queue.removeFirst()
                level.append(tree!.val)
                if tree?.left != nil {
                    queue.append(tree?.left)
                }
                if tree?.right != nil {
                    queue.append(tree?.right)
                }
            }
            ans.insert(level, at: 0)
        }
        
        return ans
    }
    
    // 108. 将有序数组转换为二叉搜索树
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        
        func helper(_ left: Int, _ right: Int) -> TreeNode? {
            if left > right {
                return nil
            }
            
            let mid = (left + right) / 2
            
            let root = TreeNode.init(nums[mid])
            root.left = helper(left, mid - 1)
            root.right = helper(mid + 1, right)
            return root
        }
        
        return helper(0, nums.count - 1)
    }
}
