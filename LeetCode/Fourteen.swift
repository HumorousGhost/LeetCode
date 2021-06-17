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
    
    // 141. 环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        /** // 方法一
        var array = [String]()
        var head = head
        while head != nil {
            if array.contains(head.debugDescription) {
                return true
            } else {
                array.append(head.debugDescription)
            }
            head = head?.next
        }
        
        return false
        */
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var fast = head?.next
        while slow.debugDescription != fast.debugDescription {
            if fast == nil || fast?.next == nil {
                return false
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return true
    }
}
