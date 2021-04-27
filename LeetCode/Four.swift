//
//  Four.swift
//  LeetCode
//
//  Created by UED on 2021/4/26.
//

import Cocoa

class Four: NSObject {
    // 41. 缺失的第一个正数
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var numsArray = nums
        let n = numsArray.count
        for i in 0..<n {
            if numsArray[i] <= 0 {
                numsArray[i] = n + 1
            }
        }
        for i in 0..<n {
            let num = abs(numsArray[i])
            if num <= n {
                numsArray[num - 1] = -abs(numsArray[num - 1])
            }
        }
        for i in 0..<n {
            if numsArray[i] > 0 {
                return i + 1
            }
        }
        return n + 1
    }
    
    // 42. 接雨水
    func trap(_ height: [Int]) -> Int {
        var ans = 0
        var left = 0, right = height.count - 1
        var leftMax = 0, rightMax = 0
        while left < right {
            leftMax = max(leftMax, height[left])
            rightMax = max(rightMax, height[right])
            if height[left] < height[right] {
                ans += leftMax - height[left];
                left += 1
            } else {
                ans += rightMax - height[right]
                right -= 1
            }
        }
        return ans
    }
}
