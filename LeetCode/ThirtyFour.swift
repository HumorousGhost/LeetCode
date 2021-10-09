//
//  ThirtyFour.swift
//  LeetCode
//
//  Created by UED on 2021/10/8.
//

import Foundation

class ThirtyFour {
    
    // 342. 4的幂
    func isPowerOffFour(_ n: Int) -> Bool {
        
        return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1
    }
    
    // 343. 整数拆分
    func integerBreak(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 2...n {
            var curMax = 0
            for j in 1..<i {
                curMax = max(curMax, max(j * (i - j), j * dp[i - j]));
            }
            dp[i] = curMax
        }
        return dp[n]
    }
}
