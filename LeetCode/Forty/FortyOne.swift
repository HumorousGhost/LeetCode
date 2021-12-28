//
//  FortyOne.swift
//  LeetCode
//
//  Created by UED on 2021/12/27.
//

import Foundation

class FortyOne {
    // 410. 分割数组的最大值
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        let n = nums.count
        var f = [[Int]](repeating: [Int](repeating: Int.max, count: m + 1), count: n + 1)
        var sub = [Int](repeating: 0, count: n + 1)
        for i in 0..<n {
            sub[i + 1] = sub[i] + nums[i]
        }
        f[0][0] = 0
        for i in 1...n {
            for j in 1...min(i, m) {
                for k in 0..<i {
                    f[i][j] = min(f[i][j], max(f[k][j - 1], sub[i] - sub[k]))
                }
            }
        }
        return f[n][m]
    }
}
