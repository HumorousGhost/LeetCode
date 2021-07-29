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
    
    // 233. 数字 1 的个数
    func countDigitOne(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }

        var res = 0
        var digit = 1
        var high = n / 10
        var curr = n % 10
        var low = 0

        while high != 0 || curr != 0 {

            if curr == 0 {
                res += high * digit
            } else if curr == 1 {
                res += (high * digit + low + 1)
            } else {
                res += (high + 1) * digit
            }

            // 左移
            low += curr * digit
            curr = high % 10
            high /= 10
            digit *= 10
        }

        return res
    }
    
    // 234. 回文链表
    func isPalindrome(_ head: ListNode?) -> Bool {
        var list = [Int]()
        var curr = head
        while curr != nil {
            list.append(curr!.val)
            curr = curr?.next
        }
        
        var left = 0
        var right = list.count - 1
        while left < right {
            if list[left] == list[right] {
                left += 1
                right -= 1
            } else {
                return false
            }
        }
        
        return true
    }
    
    // 235. 二叉搜索树的最近公共祖先
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var ancestor = root
        while true {
            if p?.val ?? 0 < ancestor?.val ?? 0 && q?.val ?? 0 < ancestor?.val ?? 0 {
                ancestor = ancestor?.left
            } else if p?.val ?? 0 > ancestor?.val ?? 0 && q?.val ?? 0 > ancestor?.val ?? 0 {
                ancestor = ancestor?.right
            } else {
                break
            }
        }
        return ancestor
    }
    
    // 236. 二叉树的最近公共祖先
    func lowestCommonAncestor2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var parent = [Int: TreeNode?]()
        var visited = [Int]()
        
        func dfs(_ root: TreeNode?) {
            guard root != nil else {
                return
            }
            if root?.left != nil {
                parent[root!.left!.val] = root
                dfs(root?.left)
            }
            if root?.right != nil {
                parent[root!.right!.val] = root
                dfs(root?.right)
            }
        }
        
        dfs(root)
        var p = p
        while p != nil {
            visited.append(p!.val)
            p = parent[p!.val] ?? nil
        }
        
        var q = q
        while q != nil {
            if visited.contains(q!.val) {
                return q
            }
            q = parent[q!.val] ?? nil
        }
        return nil
    }
    
    // 237. 删除链表中的节点
    func deleteNode(_ node: ListNode?) {
        node?.val = node?.next?.val ?? -1
        node?.next = node?.next?.next
    }
}
