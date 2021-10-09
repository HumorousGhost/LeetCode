//
//  ThirtyFour.swift
//  LeetCode
//
//  Created by UED on 2021/10/8.
//

import Foundation

class ThirtyFour {
    
    // 342. 4的幂
    func isPowerOffFour(_ n: Int) -> Bool {
        
        return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1
    }
    
    // 343. 整数拆分
    func integerBreak(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 2...n {
            var curMax = 0
            for j in 1..<i {
                curMax = max(curMax, max(j * (i - j), j * dp[i - j]));
            }
            dp[i] = curMax
        }
        return dp[n]
    }
    
    // 344. 反转字符串
    func reverseString(_ s: inout [Character]) {
        let mid = s.count / 2, length = s.count - 1
        for i in 0..<mid {
            let temp = s[i]
            s[i] = s[length - i]
            s[length - i] = temp
        }
    }
    
    // 345. 反转字符串中的元音字母
    func reverseVowels(_ s: String) -> String {
        var indexs = [Int]()
        var chars = [Character]()
        
        let _ = s.enumerated().map { (index, char) in
            if char == "a" || char == "e" || char == "i" || char == "o" || char == "u" || char == "A" || char == "E" || char == "I" || char == "O" || char == "U" {
                indexs.append(index)
                chars.append(char)
            }
        }
        if chars.count >= 2 {
            let mid = chars.count / 2, length = chars.count - 1
            for i in 0..<mid {
                let temp = chars[i]
                chars[i] = chars[length - i]
                chars[length - i] = temp
            }
        }
        var i = 0
        var result = [Character]()
        for (index, value) in s.enumerated() {
            if indexs.contains(index) {
                result.append(chars[i])
                i += 1
            } else {
                result.append(value)
            }
        }
        
        return String(result)
    }
}
