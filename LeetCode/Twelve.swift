//
//  Twelve.swift
//  LeetCode
//
//  Created by UED on 2021/6/4.
//

import Cocoa

class Twelve: NSObject {
    // 120. 三角形最小路径和
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        var f = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        f[0][0] = triangle[0][0]
        for i in 1..<n {
            f[i][0] = f[i - 1][0] + triangle[i][0]
            for j in 1..<i {
                f[i][j] = min(f[i - 1][j - 1], f[i - 1][j]) + triangle[i][j]
            }
            f[i][i] = f[i - 1][i - 1] + triangle[i][i]
        }
        var minTotal = f[n - 1][0]
        for i in 1..<n {
            minTotal = min(minTotal, f[n - 1][i])
        }
        return minTotal
    }
}
