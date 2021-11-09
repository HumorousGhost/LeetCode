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
}
