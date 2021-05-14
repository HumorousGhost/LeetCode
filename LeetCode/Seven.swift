//
//  Seven.swift
//  LeetCode
//
//  Created by UED on 2021/5/13.
//

import Cocoa

class Seven: NSObject {
    // 70. 爬楼梯
    func climbStairs(_ n: Int) -> Int {
        var p = 0, q = 0, r = 1
        for _ in 1...n {
            p = q
            q = r
            r = p + q
        }
        return r
    }
}
