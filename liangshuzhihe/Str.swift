//
//  Str.swift
//  liangshuzhihe
//
//  Created by UED on 2021/4/16.
//

import Cocoa

class Str: NSObject {

    // 实现 strStr() 函数 方法1
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        func charToInt(_ idx: Int, _ s: String) -> Int {
            let str = (s as NSString).substring(with: NSRange.init(location: idx, length: 1))
            let ascii = str.unicodeScalars[str.unicodeScalars.startIndex].value
            return Int(ascii - "a".unicodeScalars["a".unicodeScalars.startIndex].value)
        }
        
        let L = needle.count, n = haystack.count
        if L > n {
            return -1
        }
        
        // base value for the rolling hash function
        let a = 26
        // modulus value for the rolling hash function to avoid overflow
        let modulus = pow(2.0, 31.0)
        
        // compute the hash of strings haystack[L], needle[L]
        var h = 0, ref_h = 0
        for i in 0..<L {
            h = (h * a + charToInt(i, haystack)) % Int(modulus)
            ref_h = (ref_h * a + charToInt(i, needle)) % Int(modulus)
        }
        if h == ref_h {
            return 0
        }
        
        // count value to be used often : a**L % modulus
        var aL = 1
        for _ in 1...L {
            aL = (aL * a) % Int(modulus)
        }
        
        for start in 1..<n - L + 1 {
            // compute rolling hash in O(1) time
            h = (h * a - charToInt(start - 1, haystack) * aL + charToInt(start + L - 1, haystack)) % Int(modulus)
            if h == ref_h {
                return start
            }
        }
        return -1
    }
    
    // 实现 strStr() 函数 方法2
    func strStr2(_ haystack: String, _ needle: String) -> Int {
        let m = haystack.count, n = needle.count
        if n > m {
            return -1
        }
        if n == 0 {
            return 0
        }
        for i in 0...m - n {
            for j in 0..<n {
                if (haystack as NSString).substring(with: NSRange.init(location: i + j, length: 1)) != (needle as NSString).substring(with: NSRange.init(location: j, length: 1)) {
                    break
                }
                if j == n - 1 {
                    return i
                }
            }
        }
        return -1
    }
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if dividend == 0 {
            return 0
        }
        if dividend == Int.min && divisor == -1 {
            return Int.max
        }
        
        var negative: Bool
        negative = (dividend ^ divisor) < 0 // 用 异或来计算是否符号相同
        var t = abs(dividend)
        let d = abs(divisor)
        var result = 0
        let start = negative ? 0 : 1
        for i in start...31 {
            let a = 31 - i
            if (t >> a) >= d { // 找出足够大的数 2^n*divisor
                result += (1 << a) // 将结果加上2^n
                t -= (d << a) // 将被除数减去 2^n*divisor
            }
        }
        return negative ? -result : result // 符号相异取反
    }
}
