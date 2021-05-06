//
//  Five.swift
//  LeetCode
//
//  Created by UED on 2021/5/6.
//

import Cocoa

class Five: NSObject {
    // 50. Pow(x, n)
    func myPow(_ x: Double, _ n: Int) -> Double {
        
        func quickMul(_ x: Double, _ N: inout Int) -> Double {
            if N < 0 {
                N = -N
            }
            var ans: Double = 1.0
            // 贡献的初始值为 x
            var x_contribute = x
            // 在对 N 进行二进制拆分的同时计算答案
            while N > 0 {
                if N % 2 == 1 {
                    // 如果 N 二进制表示的最低位为 1，那么需要计入贡献
                    ans *= x_contribute
                }
                // 将贡献不断的平方
                x_contribute *= x_contribute
                // 舍弃 N 二进制表示的最低位，这样我们每次只要判断最低位即可
                N /= 2
            }
            return ans
        }
        
        var N = n
        return N >= 0 ? quickMul(x, &N) : 1.0 / quickMul(x, &N)
    }
}
