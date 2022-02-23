//
//  FortyThree.swift
//  LeetCode
//
//  Created by UED on 2022/1/18.
//

import Foundation

class FortyThree {
    // 430. 扁平化多级双向链表
    func flatten(_ head: Node?) -> Node? {
        guard head != nil else {
            return head
        }
        
        func dfs(_ node: Node?) -> Node? {
            var cur = node
            // 记录链表的最后一个节点
            var last: Node? = nil
            
            while cur != nil {
                var next = cur?.next
                // 如果有子节点，那么首先处理子节点
                if cur?.child != nil {
                    let childLast = dfs(cur?.child)
                    
                    next = cur?.next
                    // 将 node 与 child 相连
                    cur?.next = cur?.child
                    cur?.child?.prev = cur
                    
                    // 如果 next 不为空，就将 last 与 next 相连
                    if next != nil {
                        childLast?.next = next
                        next?.prev = childLast
                    }
                    
                    // 将 child 置空
                    cur?.child = nil
                    last = childLast
                } else {
                    last = cur
                }
                cur = next
            }
            return last
        }
        _ = dfs(head)
        return head
    }
    
    // 433. 最小基因变化
    func minMutation(_ start: String, _ end: String, _ bank: [String]) -> Int {
        guard bank.contains(end) else {
            return -1
        }
        
        var bankSet = Set(bank)
        var minStep = Int.max
        
        func backtrack(_ step: Int, _ current: String) {
            if step >= minStep {
                return
            }
            if current == end {
                minStep = step
            }
            for gene in bankSet {
                var diffCount = 0
                for index in 0..<gene.count {
                    if [Character](gene)[index] != [Character](current)[index] {
                        diffCount += 1
                    }
                    if diffCount > 1 {
                        break
                    }
                }
                if diffCount == 1 {
                    bankSet.remove(gene)
                    backtrack(step + 1, gene)
                    bankSet.insert(gene)
                }
            }
        }
        backtrack(0, start)
        return minStep == Int.max ? -1 : minStep
    }
    
    // 434. 字符串中的单词数
    func countSegments(_ s: String) -> Int {
        let sArr = s.components(separatedBy: " ")
        var count = 0
        
        for arranged in sArr {
            if arranged.count > 0 {
                count += 1
            }
        }
        
        return count
    }
    
    // 435. 无重叠区间
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        guard intervals.count > 0 else {
            return 0
        }
        
        var sortIntervals = intervals.sorted { interval1, interval2 in
            return interval1[0] < interval2[0]
        }
        
        let n = sortIntervals.count
        var ans = 0
        for i in 1..<n {
            if sortIntervals[i - 1][1] - sortIntervals[i][0] > 0 {
                ans += 1
                sortIntervals[i][1] = min(sortIntervals[i - 1][1], sortIntervals[i][1])
            }
        }
        return ans
    }
    
    // 436. 寻找有区间
    func findRightInterval(_ intervals: [[Int]]) -> [Int] {
        
        // 哈希记录每个区间的原来位置
        var map = [[Int]: Int]()
        for (index, value) in intervals.enumerated() {
            map[value] = index
        }
        
        // 根据第一个值来排序
        let sortIntervals = intervals.sorted { interval1, interval2 in
            return interval1[0] < interval2[0]
        }
        
        // 结果集
        var result = [Int](repeating: -1, count: intervals.count)
        
        // 二分法查找比它大的最小值
        for (index, interval) in intervals.enumerated() {
            var left = 0, right = sortIntervals.count - 1
            while left < right {
                let mid = left + ((right - left) >> 1)
                if sortIntervals[mid][0] >= interval[1] {
                    right = mid
                } else {
                    left = mid + 1
                }
            }
            
            if left == sortIntervals.count - 1, sortIntervals[left][0] < interval[1] {
                result[index] = -1
            } else {
                // 找到，去哈希中取位置
                result[index] = map[sortIntervals[left]]!
            }
        }
        
        return result
    }
    
    // 437. 路径总和 III
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
        
        guard root != nil else {
            return 0
        }
        
        func rootSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
            var ret = 0
            guard root != nil else {
                return 0
            }
            
            let val = root!.val
            if val == targetSum {
                ret += 1
            }
            
            ret += rootSum(root?.left, targetSum - val)
            ret += rootSum(root?.right, targetSum - val)
            return ret
        }
        
        var ret = rootSum(root, targetSum)
        ret += pathSum(root?.left, targetSum)
        ret += pathSum(root?.right, targetSum)
        return ret
    }
    
    // 438. 找到字符串中所有字母异位词
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        let sLen = s.count, pLen = p.count
        if sLen < pLen {
            return []
        }
        let a = Character("a").asciiValue!
        var counts = [Int](repeating: 0, count: 26)
        let sArr = s.map{$0}, pArr = p.map{$0}
        for i in 0..<pLen {
            counts[Int(sArr[i].asciiValue! - a)] += 1
            counts[Int(pArr[i].asciiValue! - a)] -= 1
        }
        
        var differ = 0
        for cnt in counts {
            if cnt != 0 {
                differ += 1
            }
        }
        
        var ans = [Int]()
        if differ == 0 {
            ans.append(0)
        }
        
        for i in 0..<sLen - pLen {
            let si = sArr[i].asciiValue!
            if counts[Int(si - a)] == 1 {
                // 窗口中字母 s[i] 的数量与字符串 p 中的数量从不同变得相同
                differ -= 1
            } else if counts[Int(si - a)] == 0 {
                // 窗口中字母 s[i] 的数量与字符串 p 中的数量从相同变得不同
                differ += 1
            }
            counts[Int(si - a)] -= 1
            
            let siPLen = sArr[i + pLen].asciiValue!
            if counts[Int(siPLen - a)] == -1 {
                // 窗口中字母 s[i + pLen] 的数量与字符串 p 中的数量从不同变得相同
                differ -= 1
            } else if counts[Int(siPLen - a)] == 0 {
                // 窗口中字母 s[i + pLen] 的数量与字符串 p 中的数量从相同变得不同
                differ += 1
            }
            counts[Int(siPLen - a)] += 1
            
            if differ == 0 {
                ans.append(i + 1)
            }
        }
        return ans
    }
}
