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
    
    // 123. 买卖股票的最佳时机 III
    func maxProfit3(_ prices: [Int]) -> Int {
        let n = prices.count
        var buy1 = -prices[0], sell1 = 0
        var buy2 = -prices[0], sell2 = 0
        for i in 1..<n {
            buy1 = max(buy1, -prices[i])
            sell1 = max(sell1, buy1 + prices[i])
            buy2 = max(buy2, sell1 - prices[i])
            sell2 = max(sell2, buy2 + prices[i])
        }
        return sell2
    }
    
    // 124. 二叉树中最大路径和
    func maxPathSum(_ root: TreeNode?) -> Int {
        var maxSum = Int.min
        
        func maxGain(_ node: TreeNode?) -> Int {
            if node == nil {
                return 0
            }
            
            // 递归计算左右子节点的最大贡献值
            // 只有在最大贡献值大于 0 时，才会选取对应子节点
            let leftGain = max(maxGain(node?.left), 0)
            let rightGain = max(maxGain(node?.right), 0)
            
            // 节点的最大路径和取决于该节点的值与节点的左右子节点的最大贡献值
            let priceNewpath = node!.val + leftGain + rightGain
            
            // 更新答案
            maxSum = max(maxSum, priceNewpath)
            
            // 返回节点的最大贡献值
            return node!.val + max(leftGain, rightGain)
        }
        
        _ = maxGain(root)
        
        return maxSum
    }
}
