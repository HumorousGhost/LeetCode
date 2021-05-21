//
//  Eight.swift
//  LeetCode
//
//  Created by UED on 2021/5/18.
//

import Cocoa

class Eight: NSObject {
    // 80. 删除有序数组中的重复项 II
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var map = [Int: Int]()
        var i = nums.count - 1
        while i >= 0 {
            let value = nums[i]
            map[value] = map[value] != nil ? map[value]! + 1 : 1
            if map[value]! > 2 {
                nums.remove(at: i)
            }
            i -= 1
        }
        return nums.count
    }
    
    // 81. 搜索旋转排序数组 II
    func search(_ nums: [Int], _ target: Int) -> Bool {
        
        let n = nums.count
        if n == 0 {
            return false
        }
        
        if n == 1 {
            return nums[0] == target
        }
        
        var l = 0, r = n - 1
        while l <= r {
            let mid = (l + r) / 2
            if nums[mid] == target {
                return true
            }
            if nums[l] == nums[mid] && nums[mid] == nums[r] {
                l += 1
                r -= 1
            } else if nums[l] <= nums[mid] {
                if nums[l] <= target && target < nums[mid] {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if nums[mid] < target && target <= nums[r] {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return false
    }
    
    // 82. 删除排序链表中的重复元素II
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return head
        }
        let dummy = ListNode.init(0, head)
        
        var cur: ListNode? = dummy
        
        while cur?.next != nil && cur?.next?.next != nil {
            if cur?.next?.val == cur?.next?.next?.val {
                let x = cur?.next?.val
                while cur?.next != nil && cur?.next?.val == x {
                    cur?.next = cur?.next?.next
                }
            } else {
                cur = cur?.next
            }
        }
        
        return dummy.next
    }
    
    // 83. 删除排序链表中的重复元素
    func deleteDuplicatesI(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return head
        }
        let dummy = ListNode.init(0, head)
        
        var cur: ListNode? = dummy
        
        while cur?.next != nil && cur?.next?.next != nil {
            if cur?.next?.val == cur?.next?.next?.val {
                cur?.next = cur?.next?.next
            } else {
                cur = cur?.next
            }
        }
        
        return dummy.next
    }
    
    // 84 柱状图中最大的矩形
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let n = heights.count
        var left = [Int](repeating: 0, count: n)
        var right = [Int](repeating: 0, count: n)
        
        var stack = [Int](repeating: 0, count: 0)
        
        for i in 0..<n {
            while !stack.isEmpty && heights[stack.last!] >= heights[i] {
                stack.removeLast()
            }
            left[i] = stack.isEmpty ? -1 : stack.last!
            stack.append(i)
        }
        
        stack.removeAll()
        for i in 0..<n {
            let index = n - 1 - i
            while !stack.isEmpty && heights[stack.last!] >= heights[index] {
                stack.removeLast()
            }
            right[index] = stack.isEmpty ? n : stack.last!
            stack.append(index)
        }
        
        var ans = 0
        for i in 0..<n {
            ans = max(ans, (right[i] - left[i] - 1) * heights[i])
        }
        return ans
    }
    
    // 85. 最大矩形
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        let m = matrix.count
        if m == 0 {
            return 0
        }
        let n = matrix[0].count
        
        var left = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] == "1" {
                    left[i][j] = (j == 0 ? 0 : left[i][j - 1]) + 1
                }
            }
        }
        
        var ret = 0
        for j in 0..<n { // 对于每一列，使用基于柱状图的方法
            var up = [Int](repeating: 0, count: m)
            var down = [Int](repeating: 0, count: m)
            
            var stack = [Int](repeating: 0, count: 0)
            for i in 0..<m {
                while !stack.isEmpty && left[stack.last!][j] >= left[i][j] {
                    stack.removeLast()
                }
                up[i] = stack.isEmpty ? -1 : stack.last!
                stack.append(i)
            }
            
            stack.removeAll()
            for i in 0..<m {
                let index = m - 1 - i
                while !stack.isEmpty && left[stack.last!][j] >= left[index][j] {
                    stack.removeLast()
                }
                down[index] = stack.isEmpty ? m : stack.last!
                stack.append(index)
            }
            
            for i in 0..<m {
                let height = down[i] - up[i] - 1
                let area = height * left[i][j]
                ret = max(ret, area)
            }
        }
        return ret
    }
    
    // 86. 分隔链表
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let dummy = ListNode.init(0, head)
        let maxNode = ListNode.init(0)
        var cur: ListNode? = dummy
        var curNode: ListNode? = maxNode
        
        while cur?.next != nil {
            if cur!.next!.val >= x {
                curNode?.next = cur?.next
                curNode = curNode?.next
                cur?.next = cur?.next?.next
            } else {
                cur = cur?.next
            }
        }
        curNode?.next = nil
        cur?.next = maxNode.next
        return dummy.next
    }
    
    // 87. 扰乱字符串
    func  isScramble(_ s1: String, _ s2: String) -> Bool {
        
        let length = s1.count
        
        let s1Arr = s1.map { String($0) }
        let s2Arr = s2.map { String($0) }
        
        // 记忆化搜索存储状态的数组
        // -1 表示 false，1 表示 true，0 表示未计算
        var memo = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: length + 1), count: length), count: length)
        
        
        func checkIfSimilar(_ i1: Int, _ i2: Int, _ length: Int) -> Bool {
            var freq = [String: Int]()
            for i in i1..<i1 + length {
                let c = s1Arr[i]
                freq[c] = freq[c] != nil ? freq[c]! + 1 : 1
            }
            for i in i2..<i2 + length {
                let c = s2Arr[i]
                freq[c] = freq[c] != nil ? freq[c]! - 1 : -1
            }
            
            for (_, value) in freq {
                if value != 0 {
                    return false
                }
            }
            return true
        }
        
        
        // 第一个字符串从 i1 开始，第二个字符串从 i2 开始，子串的长度为 length，是否和谐
        func dfs(_ i1: Int, _ i2: Int, _ length: Int) -> Bool {
            if memo[i1][i2][length] != 0 {
                return memo[i1][i2][length] == 1
            }
            
            // 判断两个子串是否相等
            if (s1 as NSString).substring(with: _NSRange.init(location: i1, length: length)) == (s2 as NSString).substring(with: _NSRange.init(location: i2, length: length)) {
                memo[i1][i2][length] = 1
                return true
            }
            
            // 判断是否存在字符 c 在两个子串中出现的次数不同
            if !checkIfSimilar(i1, i2, length) {
                memo[i1][i2][length] = -1
                return false
            }
            
            // 枚举分割位置
            for i in 1..<length {
                // 不交换的情况
                if dfs(i1, i2, i) && dfs(i1 + i, i2 + i, length - i) {
                    memo[i1][i2][length] = 1
                    return true
                }
                
                // 交换的情况
                if dfs(i1, i2 + length - i, i) && dfs(i1 + i, i2, length - i) {
                    memo[i1][i2][length] = 1
                    return true
                }
            }
            
            memo[i1][i2][length] = -1
            return false
        }
        
        return dfs(0, 0, length)
    }
    
    // 88. 合并两个有序数组
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        for i in 0..<n {
            nums1[m + i] = nums2[i]
        }
        nums1.sort()
    }
    
    // 89. 格雷编码
    func grayCode(_ n: Int) -> [Int] {
        var ans = [Int](repeating: 0, count: 0)
        ans.append(0)
        // 判断边界情况
        if n < 1 {
            return ans
        }
        // 将 1 添加进去，此时对应 n 为 1
        ans.append(1)
        if n == 1 {
            return ans
        }
        // 结果数组的当前大小
        var size = ans.count
        // 临时变量用于镜像计算
        var temp = 0
        // 从 n = 2 的情况开始遍历
        for _ in 2...n {
            size = ans.count
            for j in 0..<size {
                let index = size - 1 - j
                temp = ans[index] * 2
                // 对应下半部分，这里还没有初始值，需添加新的进去
                ans.append(temp + 1)
                // 对应上半部分，这里已经有初始值，需要修改
                ans[index] = temp
            }
        }
        return ans
    }
}
