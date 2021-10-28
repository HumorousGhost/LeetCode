//
//  ThirtySeven.swift
//  LeetCode
//
//  Created by UED on 2021/10/27.
//

import Foundation

class ThirtySeven {
    // 371. 两整数之和
    func getSum(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while b != 0 {
            let temp = (a & b) << 1
            a = a ^ b
            b = temp
        }
        return a
    }
    
    // 372. 超级次方
    func superPow(_ a: Int, _ b: [Int]) -> Int {
        
        let mod = 1337
        
        func modPow(_ base: Int, _ exponent: Int) -> Int {
            var ans = 1, base = base, exponent = exponent
            
            while exponent > 0 {
                if exponent & 1 == 1 {
                    ans = (base * ans) % mod
                }
                base = (base * base) % mod
                exponent >>= 1
            }
            return ans
        }
        
        var base = a % mod, ans = 1, x = base
        
        b.reversed().forEach { bit in
            ans = (ans * modPow(x, bit)) % mod
            x = modPow(x, 10) % mod
        }
        return ans
    }
}
