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
    
}
