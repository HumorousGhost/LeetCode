//
//  ThirtyNine.swift
//  LeetCode
//
//  Created by UED on 2021/11/15.
//

import Foundation

class ThirtyNine {
    // 390. 消除游戏
    func lastRemaining(_ n: Int) -> Int {
        
        func dfs(_ start: Int, _ step: Int, _ n: Int) -> Int {
            if n == 1 {
                return start
            }
            return dfs(start + (n - 1 - (n & 1)) * step, step * -2, n / 2)
        }
        
        return dfs(1, 1, n)
    }
}
