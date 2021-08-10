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
}
