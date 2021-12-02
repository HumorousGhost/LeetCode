//
//  TwentyNine.swift
//  LeetCode
//
//  Created by UED on 2021/8/9.
//

import Foundation

class TwentyNine {
    // 290. 单词规律
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        var str2ch = [String: Character]()
        var ch2str = [Character: String]()
        
        let m = s.count
        let str = s.map({String($0)})
        var i = 0
        for char in pattern {
            if i >= m {
                return false
            }
            var j = i
            while j < m && str[j] != " " {
                j += 1
            }
            let tmp = str[i..<j].joined()
            if str2ch.keys.contains(tmp) && str2ch[tmp] != char {
                return false
            }
            if ch2str.keys.contains(char) && ch2str[char] != tmp {
                return false
            }
            str2ch[tmp] = char
            ch2str[char] = tmp
            i = j + 1
        }
        return i >= m
    }
    
    // 292. Nim 游戏
    func canWinNim(_ n: Int) -> Bool {
        return n % 4 != 0
    }
    
    // 299. 猜数字游戏
    func getHint(_ secret: String, _ guess: String) -> String {
        var a = 0, b = 0
        let ascii0 = Character("0").asciiValue!
        var nums = [Int](repeating: 0, count: 10)
        for (c1, c2) in zip(secret, guess) {
            if c1 == c2 {
                a += 1
            } else {
                let i = Int(c1.asciiValue! - ascii0)
                let j = Int(c2.asciiValue! - ascii0)
                // 小于 0 说明 c1 在 guess 中出现过
                if nums[i] < 0 {
                    b += 1
                }
                // 大于 0 说明 c2 在 secret 中出现过
                if nums[j] > 0 {
                    b += 1
                }
                nums[i] += 1
                nums[j] -= 1
            }
        }
        return "\(a)A\(b)B"
    }
}
