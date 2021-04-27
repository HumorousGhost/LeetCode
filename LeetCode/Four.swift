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
    
    // 43. 字符串相乘
    func mutiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        if num1 == "1" {
            return num2
        }
        if num2 == "1" {
            return num1
        }
        
        let m = num1.count, n = num2.count
        var ansArr = [Int](repeating: 0, count: m + n)
        for valuei in 0...m - 1 {
            let i = m - 1 - valuei
            let x = ((num1 as NSString).substring(with: NSRange.init(location: i, length: 1)) as NSString).integerValue
            for valuej in 0...n - 1 {
                let j = n - 1 - valuej
                let y = ((num2 as NSString).substring(with: NSRange.init(location: j, length: 1)) as NSString).integerValue
                ansArr[i + j + 1] += x * y
            }
        }
        var i = m + n - 1
        while i > 0 {
            ansArr[i - 1] += ansArr[i] / 10
            ansArr[i] %= 10
            i -= 1
        }
        var index = ansArr[0] == 0 ? 1 : 0
        var ans = ""
        while index < m + n {
            ans.append(String(ansArr[index]))
            index += 1
        }
        return ans
    }
}
