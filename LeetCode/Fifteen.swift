//
//  Fifteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/22.
//

import Cocoa

class Fifteen: NSObject {
    // 150. 逆波兰表达式求值
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for token in tokens {
            if token == "+" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 + sum1)
            } else if token == "-" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 - sum1)
            } else if token == "*" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 * sum1)
            } else if token == "/" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 / sum1)
            } else {
                stack.append((token as NSString).integerValue)
            }
        }
        return stack.removeLast()
    }
    
    // 151. 翻转字符串里的单词
    func reverseWords(_ s: String) -> String {
        let sArr = s.components(separatedBy: " ")
        var newArr = [String]()
        for i in 0..<sArr.count {
            if sArr[i] != "" {
                newArr.insert(sArr[i], at: 0)
            }
        }
        return newArr.joined(separator: " ")
    }
    
    // 152. 乘积最大子数组
    func maxProduct(_ nums: [Int]) -> Int {
        var maxF = nums[0], minF = nums[0], ans = nums[0]
        let length = nums.count
        for i in 1..<length {
            let mx = maxF, mn = minF
            maxF = max(mx * nums[i], max(nums[i], mn * nums[i]))
            minF = min(mn * nums[i], min(nums[i], mx * nums[i]))
            ans = max(maxF, ans)
        }
        return ans
    }
    
    // 153. 寻找旋转排序数组中的最小值
    func findMin(_ nums: [Int]) -> Int {
        var left = 0, right = nums.count - 1
        var minValue = nums[0]
        while left <= right {
            let mid = (left + right) / 2
            if nums[left] <= nums[mid] {
                minValue = min(minValue, nums[left])
                left = mid + 1
            } else {
                minValue = min(minValue, nums[mid])
                right = mid - 1
            }
        }
        return minValue
    }
}
