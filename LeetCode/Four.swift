//
//  Four.swift
//  LeetCode
//
//  Created by UED on 2021/4/22.
//

import Cocoa

class Four: NSObject {
    // 31. 下一个排列
    func nextPermutation(_ nums: inout [Int]) {
        func swap(nums: inout [Int], i: Int, j: Int) {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }
        
        func reverse(nums: inout [Int], start: Int) {
            var left = start, right = nums.count - 1
            while left < right {
                swap(nums: &nums, i: left, j: right)
                left += 1
                right -= 1
            }
        }
        
        var i = nums.count - 2
        while i >= 0 && nums[i] >= nums[i + 1] {
            i -= 1
        }
        if i >= 0 {
            var j = nums.count - 1
            while j >= 0 && nums[i] >= nums[j] {
                j -= 1
            }
            swap(nums: &nums, i: i, j: j)
        }
        reverse(nums: &nums, start: i + 1)
    }
    
    // 32. 最长有效括号
    func longestValidParentheses(_ s: String) -> Int {
        var maxans = 0
        var stack = [Int]()
        stack.append(-1)
        let stringArray = s.map{ $0 }
        for i in 0..<s.count {
            if stringArray[i] == "(" {
                stack.append(i)
            } else {
                stack.removeLast()
                if stack.count == 0 {
                    stack.append(i)
                } else {
                    maxans = max(maxans, i - (stack.last ?? -1))
                }
            }
        }
        return maxans
    }
    
    // 33. 搜索旋转排序数组
    func search(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        if n == 0 {
            return -1
        }
        if n == 1 {
            return nums.first == target ? 0 : -1
        }
        
        var l = 0, r = n - 1
        while l <= r {
            let mid = (l + r) / 2
            if nums[mid] == target {
                return mid
            }
            if nums[0] <= nums[mid] {
                if nums[0] <= target && target < nums[mid] {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if nums[mid] < target && target <= nums[n - 1] {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return -1
    }
    
    // 34. 在排序数组中查找元素的第一个和最后一个位置
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        func binarySearch(_ nums: [Int], _ target: Int, _ lower: Bool) -> Int {
            var left = 0, right = nums.count - 1, ans = nums.count
            while left <= right {
                let mid = (left + right) / 2
                if nums[mid] > target || (lower && nums[mid] >= target) {
                    right = mid - 1
                    ans = mid
                } else {
                    left = mid + 1
                }
            }
            return ans
        }
        
        let leftIdx = binarySearch(nums, target, true)
        let rightIdx = binarySearch(nums, target, false) - 1
        if leftIdx <= rightIdx && rightIdx < nums.count && nums[leftIdx] == target && nums[rightIdx] == target {
            return [leftIdx, rightIdx]
        }
        return [-1, -1]
    }
    
    // 35. 搜索插入位置
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        var left = 0, right = n - 1, ans = n
        while left <= right {
            let mid = (left + right) / 2
            if target <= nums[mid] {
                ans = mid
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return ans
    }
    
    // 36. 有效的数独
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var rows = [Int : NSMutableDictionary]()
        var columns = [Int : NSMutableDictionary]()
        var boxes = [Int : NSMutableDictionary]()
        for i in 0..<9 {
            rows[i] = NSMutableDictionary()
            columns[i] = NSMutableDictionary()
            boxes[i] = NSMutableDictionary()
        }
        
        // validate a board
        for i in 0..<9 {
            for j in 0..<9 {
                let num = board[i][j]
                if num != "." {
                    let n = (String.init(num) as NSString).integerValue
                    let box_index = (i / 3) * 3 + j / 3
                    
                    // keep the current cell value
                    rows[i]?.addEntries(from: [n : rows[i]![n] != nil ? rows[i]![n]! as! Int + 1 : 1])
                    columns[j]?.addEntries(from: [n : columns[j]![n] != nil ? columns[j]![n]! as! Int + 1 : 1])
                    boxes[box_index]?.addEntries(from: [n : boxes[box_index]![n] != nil ? boxes[box_index]![n]! as! Int + 1 : 1])
                    
                    // check if this value has been already seen before
                    if rows[i]![n]! as! Int > 1 || columns[j]![n]! as! Int > 1 || boxes[box_index]![n]! as! Int > 1 {
                        return false
                    }
                }
            }
        }
        return true
    }
}
