//
//  Six.swift
//  LeetCode
//
//  Created by UED on 2021/5/10.
//

import Cocoa

class Six: NSObject {
    // 60. 排列序列
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var factorial = [Int](repeating: 0, count: n)
        factorial[0] = 1
        for i in 1..<n {
            factorial[i] = factorial[i - 1] * i
        }
        var kValue = k - 1
        var ans = ""
        var valid = [Int](repeating: 1, count: n + 1)
        for i in 1...n {
            var order = kValue / factorial[n - i] + 1
            for j in 1...n {
                order -= valid[j]
                if order == 0 {
                    ans.append(String(j))
                    valid[j] = 0
                    break
                }
            }
            kValue %= factorial[n - i]
        }
        return ans
    }
}
