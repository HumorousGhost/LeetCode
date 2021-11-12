//
//  ThirtyEight.swift
//  LeetCode
//
//  Created by UED on 2021/11/8.
//

import Foundation

class ThirtyEight {
    // 383. 赎金信
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        guard ransomNote.count <= magazine.count else {
            return false
        }
        var dicOfRansom = [Character: Int]()
        for char in ransomNote {
            dicOfRansom[char, default: 0] += 1
        }
        
        for char in magazine {
            if let time = dicOfRansom[char] {
                if time > 1 {
                    dicOfRansom[char]! -= 1
                } else {
                    dicOfRansom.removeValue(forKey: char)
                    if dicOfRansom.isEmpty {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // 385. 迷你语法分析器
    func deserialize(_ s: String) -> NestedInteger {
        
        var integerStr = ""
        var stack = [NestedInteger()]
        var lastInteger = stack.first
        
        func transformInteger() -> NestedInteger? {
            guard let val = Int(integerStr) else {
                return nil
            }
            let integer = NestedInteger()
            integer.setInteger(val)
            integerStr = ""
            return integer
        }
        
        s.forEach { char in
            switch char {
            case "[":
                let integer = NestedInteger()
                lastInteger?.add(integer)
                lastInteger = integer
                stack.append(integer)
                break
            case "]":
                if let integer = transformInteger() {
                    lastInteger?.add(integer)
                }
                stack.removeLast()
                break
            case "-", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
                integerStr.append(char)
                break
            case ",":
                lastInteger = stack.last
                guard let integer = transformInteger() else {
                    return
                }
                lastInteger?.add(integer)
                break
            default:
                break
            }
        }
        
        if let integer = transformInteger() {
            lastInteger?.add(integer)
        }
        
        return stack.first?.getList().first ?? NestedInteger()
    }
    
    // 386. 字典序排数
    func lexicalOrder(_ n: Int) -> [Int] {
        guard n >= 1 else {
            return []
        }
        
        var result = [Int]()
        
        func dfs(_ prefix: Int) {
            guard prefix <= n else {
                return
            }
            result.append(prefix)
            let c = prefix * 10
            (c...c + 9).forEach ({
                dfs($0)
            })
        }
        
        (1...9).forEach({
            dfs($0)
        })
        
        return result
    }
}
