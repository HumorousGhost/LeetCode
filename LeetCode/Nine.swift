//
//  Nine.swift
//  LeetCode
//
//  Created by UED on 2021/5/21.
//

import Cocoa

class Nine: NSObject {
    // 90. 子集 II
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var t = [Int](repeating: 0, count: 0)
        var ans = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        
        func dfs(_ choosePre: Bool, _ cur: Int, _ nums: [Int]) {
            if cur == nums.count {
                ans.append(t)
                return
            }
            dfs(false, cur + 1, nums)
            if !choosePre && cur > 0 && nums[cur - 1] == nums[cur] {
                return
            }
            t.append(nums[cur])
            dfs(true, cur + 1, nums)
            t.removeLast()
        }
        
        let sortNums = nums.sorted()
        dfs(false, 0, sortNums)
        return ans
    }
    
    // 91. 解码方法
    func numDecodings(_ s: String) -> Int {
        let n = s.count
        let sArr = s.map { String($0) }
        var f = [Int](repeating: 0, count: n + 1)
        f[0] = 1
        for i in 1...n {
            if sArr[i - 1] != "0" {
                f[i] += f[i - 1]
            }
            
            if i > 1 && sArr[i - 2] != "0" && (sArr[i - 2] as NSString).integerValue * 10 + (sArr[i - 1] as NSString).integerValue <= 26 {
                f[i] += f[i - 2]
            }
        }
        return f[n]
    }
    
    // 92. 反转链表 II
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        // 设置 dummyNode
        let dummyNode = ListNode.init(-1, head)
        // 找到 left 前一个节点
        var pre: ListNode? = dummyNode
        for _ in 0..<left - 1 {
            pre = pre?.next
        }
        // 待翻转节点
        let cur = pre?.next
        var next: ListNode?
        for _ in 0..<right - left {
            next = cur?.next
            cur?.next = next?.next
            next?.next = pre?.next
            pre?.next = next
        }
        
        return dummyNode.next
    }
    
    // 93. 复原 IP 地址
    func restoreIpAddresses(_ s: String) -> [String] {
        let COUNT = 4
        var ans = [String](repeating: "", count: 0)
        var segments = [Int](repeating: 0, count: COUNT)
        let sArr = s.map { String($0) }
        
        func dfs(_ segId: Int, _ segStart: Int) {
            // 如果找到了 4 段 IP 地址并且遍历完了字符串，那么就是一种答案
            if segId == COUNT {
                if segStart == sArr.count {
                    var ipAddr = ""
                    for i in 0..<COUNT {
                        ipAddr.append(String(segments[i]))
                        if i != COUNT - 1 {
                            ipAddr.append(".")
                        }
                    }
                    ans.append(ipAddr)
                }
                return
            }
            
            // 如果还没有找到 4 段 IP 地址就已经遍历完了字符串，那么提前回溯
            if segStart == sArr.count {
                return
            }
            
            // 由于不能前导零，如果当前数字为 0，那么这一段 IP 地址只能为 0
            if sArr[segStart] == "0" {
                segments[segId] = 0
                dfs(segId + 1, segStart + 1)
            }
            
            // 一般情况，枚举每一种可能性并递归
            var addr = 0
            for segEnd in segStart..<sArr.count {
                addr = addr * 10 + (sArr[segEnd] as NSString).integerValue
                if addr > 0 && addr <= 0xFF {
                    segments[segId] = addr
                    dfs(segId + 1, segEnd + 1)
                } else {
                    break
                }
            }
        }
        
        dfs(0, 0)
        
        return ans
    }
    
    // 94. 二叉树的中序遍历
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int](repeating: 0, count: 0)
        
        func inorder(_ root: TreeNode?) {
            if root == nil {
                return
            }
            inorder(root?.left)
            res.append(root!.val)
            inorder(root?.right)
        }
        
        inorder(root)
        
        return res
    }
    
    // 95. 不同的二叉搜索树 II
    func generateTrees(_ n: Int) -> [TreeNode?] {
        if n == 0 {
            return []
        }
        
        func generateTrees(_ start: Int, _ end: Int) -> [TreeNode?] {
            var allTrees = [TreeNode?]()
            if start > end {
                allTrees.append(nil)
                return allTrees
            }
            
            // 枚举可行根节点
            for i in start...end {
                // 获得所有可行的左子树集合
                let leftTrees = generateTrees(start, i - 1)
                
                // 获取所有可行的右子树集合
                let rightTrees = generateTrees(i + 1, end)
                
                // 从左子树集合中选出一颗左子树，从右子树集合中选出一颗右子树，拼接到根节点上
                for left in leftTrees {
                    for right in rightTrees {
                        let currTree = TreeNode.init(i)
                        currTree.left = left
                        currTree.right = right
                        allTrees.append(currTree)
                    }
                }
            }
            return allTrees
        }
        
        return generateTrees(1, n)
    }
    
    // 96. 不同的二叉搜索树
    func numTrees(_ n: Int) -> Int {
        var C = 1
        for i in 0..<n {
            C = C * 2 * (2 * i + 1) / (i + 2)
        }
        return C
    }
    
    // 97. 交错字符串
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let n = s1.count, m = s2.count, t = s3.count
        
        if n + m != t {
            return false
        }
        
        let s1Arr = s1.map { String($0) }
        let s2Arr = s2.map { String($0) }
        let s3Arr = s3.map { String($0) }
        
        var f = [Bool](repeating: false, count: m + 1)
        
        f[0] = true
        for i in 0...n {
            for j in 0...m {
                let p = i + j - 1
                if i > 0 {
                    f[j] = f[j] && s1Arr[i - 1] == s3Arr[p]
                }
                if j > 0 {
                    f[j] = f[j] || (f[j - 1] && s2Arr[j - 1] == s3Arr[p])
                }
            }
        }
        
        return f[m]
    }
}
