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
    
    // 301. 删除无效的括号
    func removeInvalidParentheses(_ s: String) -> [String] {
        
        func isVaild(_ s: String) -> Bool {
            var count = 0
            let strArray = [Character](s)
            for i in 0..<s.count {
                if strArray[i] == "(" {
                    count += 1
                } else if strArray[i] == ")" {
                    count -= 1
                }
                if count < 0 {
                    //出现只有右括号在前的case
                    return false
                }
            }
            return count == 0
        }

        var res = [String]()
        var queue = [String]()
        var visited = Set<String>()
                
        queue.append(s)
                
        while true {
            let size = queue.count
            //考虑当前层
            for _ in 0..<size {
                let str = queue.removeFirst()
                if isVaild(str) {
                    res.append(str)
                } else if res.isEmpty {
                    //生成下一层，原来的基础上再多删除一个括号
                    for removei in 0..<str.count {
                        let removeIndex = str.index(str.startIndex, offsetBy: removei)
                        if str[removeIndex] == "(" || str[removeIndex] == ")" {
                            var newstr = str
                            newstr.remove(at: removeIndex)
                            let nexts = newstr
                            //防止重复
                            if !visited.contains(nexts) {
                                queue.append(nexts)
                                visited.insert(nexts)
                            }
                        }
                    }
                }
            }
            //出现了合法字符串，终止循环
            if res.count > 0 {
                break
            }
        }
        
        return res
    }
    
    // 306. 累加数
    func isAdditiveNumber(_ num: String) -> Bool {
        let numArr = num.map({$0})
        let length = numArr.count
        
        ///
        /// - Parameters:
        ///   - index: 当前的下标
        ///   - sum: 前两个数的和
        ///   - previous: 前一个数的值
        ///   - count: 已生成几个数
        /// - Returns: <#description#>
        func toFlashBack(_ index: Int, _ sum: Double, _ previous: Double, _ count: Int) -> Bool {
            // 如果已生成三个数及以上则返回 true
            if index == length {
                return count >= 3
            }
            
            // 拼接数字的值, 值可能越 Int 的界 所以使用 Double
            var value: Double = 0
            // 开始拼接数字
            for i in index..<length {
                // 除 0 以外，其他数字第一位不能为 0
                if i > index && numArr[index] == "0" {
                    break
                }
                
                // 计算数值
                value = value * 10 + Double(numArr[i].asciiValue! - Character("0").asciiValue!)
                
                // 判断数值是否合法，如果前面有两个以上的数，则判断当前两个数的和是否等于这个数
                if count >= 2 {
                    if value < sum {
                        // 小的话继续向后继续拼接
                        continue
                    } else if value > sum {
                        // 大的话直接结束，再向后拼接无意义
                        break
                    }
                }
                
                // 使用该数，向下递归
                if toFlashBack(i + 1, previous + value, value, count + 1) {
                    return true
                }
                // 没有可恢复原样的变量
            }
            return false
        }
        
        return toFlashBack(0, 0, 0, 0)
    }
    
    // 309. 最佳买卖股票时机含冷冻期
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else {
            return 0
        }
        
        let n = prices.count
        // f[i][0]: 手上持有股票的最大收益
        // f[i][1]: 手上不持有股票，并且处于冷冻期中的累计最大收益
        // f[i][2]: 手上不持有股票，并且不在冷冻期中的累计最大收益
        var f = [[Int]](repeating: [Int](repeating: 0, count: 3), count: n)
        f[0][0] = -prices[0]
        for i in 1..<n {
            f[i][0] = max(f[i - 1][0], f[i - 1][2] - prices[i])
            f[i][1] = f[i - 1][0] + prices[i]
            f[i][2] = max(f[i - 1][1], f[i - 1][2])
        }
        
        return max(f[n - 1][1], f[n - 1][2])
    }
}
