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
    
    // 387. 字符串中的第一个唯一字符
    func firstUniqChar(_ s: String) -> Int {
        var dict = [Character: Int]()
        for char in s {
            dict[char, default: 0] += 1
        }
        for (index, char) in s.enumerated() {
            if let num = dict[char], num == 1 {
                return index
            }
        }
        return -1
    }
    
    // 388. 文件的最长绝对路径
    func lengthLongestPath(_ input: String) -> Int {
        guard input.count > 0 else {
            return 0
        }
        
        struct Node {
            var level: Int
            var sum: Int
            init(_ level: Int, _ sum: Int) {
                self.level = level
                self.sum = sum
            }
        }
        
        func countTab(_ s: String) -> Int {
            var temp = ""
            var count = 0
            while true {
                temp.append("\t")
                if s.hasPrefix(temp) {
                    count += 1
                } else {
                    break
                }
            }
            return count
        }
        
        let splits = input.components(separatedBy: "\n")
        var stack = [Node]()
        
        var res = 0
        var i = 0
        while i < splits.count {
            let howMayTabs = countTab(splits[i])
            
            if stack.isEmpty {
                if splits[i].contains(".") {
                    res = max(res, splits[i].count)
                } else {
                    let newNode = Node(howMayTabs, splits[i].count - howMayTabs)
                    stack.append(newNode)
                }
                i += 1
            } else {
                let peek = stack.last!
                // 上下级关系
                if peek.level + 1 == howMayTabs {
                    let newNode = Node(howMayTabs, splits[i].count + peek.sum - howMayTabs + 1)
                    if splits[i].contains(".") {
                        res = max(res, newNode.sum)
                    } else {
                        stack.append(newNode)
                    }
                    i += 1
                } else {
                    stack.removeLast()
                }
            }
        }
        
        return res
    }
    
    // 389. 找不同
    func findTheDifference(_ s: String, _ t: String) -> Character {
        var map = [Character: Int]()
        for char in t {
            map[char, default: 0] += 1
        }
        for char in s {
            map[char, default: 0] -= 1
            if map[char] == 0 {
                map.removeValue(forKey: char)
            }
        }
        for (key, _) in map {
            return key
        }
        return Character("")
    }
}
