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
}
