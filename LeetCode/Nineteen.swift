//
//  Nineteen.swift
//  LeetCode
//
//  Created by UED on 2021/7/6.
//

import Foundation

class Nineteen {
    // 190. 颠倒二进制位
    func reverseBits(_ n: Int) -> Int {
        var rev = 0, n = n
        var i = 0
        while i < 32 && n > 0 {
            rev |= (n & 1) << (31 - i)
            n >>= 1
            i += 1
        }
        return rev
    }
}
