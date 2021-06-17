//
//  Fourteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/16.
//

import Cocoa

class Fourteen: NSObject {
    // 140. 单词拆分 II
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        var map = [Int: [[String]]]()
        let sArr = s.map { String($0) }
        
        func backtrack(_ length: Int, _ index: Int) -> [[String]] {
            if !map.keys.contains(index) {
                var wordBreaks = [[String]]()
                if index == length {
                    wordBreaks.append([String]())
                } else {
                    for i in index + 1...length {
                        let word = sArr[index..<i].joined()
                        if wordDict.contains(word) {
                            let nextWordBreaks = backtrack(length, i)
                            for nextWordBreak in nextWordBreaks {
                                var wordBreak = nextWordBreak
                                wordBreak.insert(word, at: 0)
                                wordBreaks.append(wordBreak)
                            }
                        }
                    }
                }
                map[index] = wordBreaks
            }
            return map[index]!
        }
        
        let wordBreaks = backtrack(s.count, 0)
        var breakList = [String]()
        for wordBreak in wordBreaks {
            breakList.append(wordBreak.joined(separator: " "))
        }
        return breakList
    }
}
