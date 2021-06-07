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
    
    // 121. 买卖股票的最佳时机
    func maxProfit(_ prices: [Int]) -> Int {
        var price = 0
        var minPrice = Int.max
        for i in 0..<prices.count {
            if prices[i] < minPrice {
                minPrice = prices[i]
            } else if prices[i] - minPrice > price {
                price = prices[i] - minPrice
            }
        }
        return price
    }
    
    // 122. 买卖股票的最佳时机 II
    func maxProfit2(_ prices: [Int]) -> Int {
        var ans = 0
        let n = prices.count
        for i in 1..<n {
            ans += max(0, prices[i] - prices[i - 1])
        }
        return ans
    }
}
