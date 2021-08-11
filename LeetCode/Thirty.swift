//
//  Thirty.swift
//  LeetCode
//
//  Created by UED on 2021/8/11.
//

import Foundation

class Thirty {
    // 300. 最长递增子序列
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        if nums.count == 1 {
            return 1
        }
        let count = nums.count
        var dp = [Int](repeating: 0, count: count)
        dp[0] = 1
        var maxans = 1
        for i in 1..<count {
            dp[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
            maxans = max(maxans, dp[i])
        }
        return maxans
    }
}
