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
}
