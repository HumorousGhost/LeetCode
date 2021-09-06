//
//  ThirtyTwo.swift
//  LeetCode
//
//  Created by UED on 2021/9/1.
//

import Foundation

class ThirtyTwo {
    // 321. 拼接最大数
    func maxNumber(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [Int] {
        func compare(_ subsequence1: [Int], _ index1: Int, _ subsequence2: [Int], _ index2: Int) -> Int {
            var index1 = index1, index2 = index2
            let x = subsequence1.count, y = subsequence2.count
            while index1 < x && index2 < y {
                let difference = subsequence1[index1] - subsequence2[index2]
                if difference != 0 {
                    return difference
                }
                index1 += 1
                index2 += 1
            }
            return (x - index1) - (y - index2)
        }
        
        func merge(_ subsequence1: [Int], _ subsequence2: [Int]) -> [Int] {
            let x = subsequence1.count, y = subsequence2.count
            if x == 0 {
                return subsequence2
            }
            if y == 0 {
                return subsequence1
            }
            
            let mergeCount = x + y
            var merged = [Int](repeating: 0, count: mergeCount)
            var index1 = 0, index2 = 0
            for i in 0..<mergeCount {
                if compare(subsequence1, index1, subsequence2, index2) > 0 {
                    merged[i] = subsequence1[index1]
                    index1 += 1
                } else {
                    merged[i] = subsequence2[index2]
                    index2 += 1
                }
            }
            return merged
        }
        
        func maxSubsequence(_ nums: [Int], _ k: Int) -> [Int] {
            var stack = [Int](repeating: 0, count: k)
            var top = -1, remain = nums.count - k
            for num in nums {
                while top >= 0 && stack[top] < num && remain > 0 {
                    top -= 1
                    remain -= 1
                }
                if top < k - 1 {
                    top += 1
                    stack[top] = num
                } else {
                    remain -= 1
                }
            }
            return stack
        }
        
        let m = nums1.count, n = nums2.count
        var subsequence = [Int](repeating: 0, count: k)
        let start = max(0, k - n), end = min(k, m)
        for i in start...end {
            let subsequence1 = maxSubsequence(nums1, i)
            let subsequence2 = maxSubsequence(nums2, k - i)
            let curMaxSubsequence = merge(subsequence1, subsequence2)
            if compare(curMaxSubsequence, 0, subsequence, 0) > 0 {
                subsequence = curMaxSubsequence
            }
        }
        
        return subsequence
    }
    
    // 322. 零钱兑换
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard amount != 0 else {
            return 0
        }
        let max = amount + 1
        var dp = [Int](repeating: max, count: amount + 1)
        dp[0] = 0
        for i in 1...amount {
            for j in 0..<coins.count {
                if coins[j] <= i {
                    dp[i] = min(dp[i], dp[i - coins[j]] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]
    }
}
