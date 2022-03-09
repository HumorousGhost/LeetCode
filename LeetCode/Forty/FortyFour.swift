//
//  FortyFour.swift
//  LeetCode
//
//  Created by UED on 2022/2/23.
//

import Foundation

class FortyFour {
    // 440. 字典序的第K小数字
    func findKthNumber(_ n: Int, _ k: Int) -> Int {
        
        func stepCount(_ n: Int, _ node: Int) -> Int {
            var cur = node, next = node + 1, sum = 0
            while cur <= n {
                sum += min(n - cur + 1, next - cur)
                cur *= 10
                next *= 10
            }
            return sum
        }
        
        var cur = 1, needStep = k - 1
        
        while needStep > 0 {
            let tempStep = stepCount(n, cur)
            if tempStep > needStep {
                cur *= 10
                needStep -= 1
            } else {
                cur += 1
                needStep -= tempStep
            }
        }
        
        return cur
    }
    
    // 441. 排列硬币
    func arrangeCoins(_ n: Int) -> Int {
        var sum = 0
        for i in 0..<n {
            sum += i + 1
            if sum == n {
                return i + 1
            } else if sum > n {
                return i
            }
        }
        return 0
    }
    
    // 442. 数组中重复的数据
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var newNums = nums
        var res = [Int]()
        for i in 0..<newNums.count {
            let index = abs(newNums[i]) - 1
            if newNums[index] < 0 {
                res.append(index + 1)
                continue
                
            }
            newNums[index] = -newNums[index]
        }
        return res
    }
    
    // 443. 压缩字符串
    func compress(_ chars: inout [Character]) -> Int {
        guard chars.count > 1 else {
            return chars.count
        }
        
        var markIndex = 0
        var rangeCount = 0
        
        for flag in 0..<chars.count {
            rangeCount += 1
            if flag == chars.count - 1 || chars[flag] != chars[flag + 1] {
                // 计算阶段
                chars[markIndex] = chars[flag]
                markIndex += 1
                if rangeCount > 1 {
                    let rangeString = "\(rangeCount)"
                    let rangeArray = rangeString.map({$0})
                    var rangeIndex = 0
                    while rangeIndex < rangeArray.count {
                        let rangeChar = rangeArray[rangeIndex]
                        chars[markIndex] = rangeChar
                        markIndex += 1
                        rangeIndex += 1
                    }
                }
                rangeCount = 0
            }
        }
        return markIndex
    }
}
