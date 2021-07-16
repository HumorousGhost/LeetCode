//
//  WordDictionary.swift
//  LeetCode
//
//  Created by UED on 2021/7/16.
//

import Foundation

// 211. 添加与搜索单词 - 数据结构设计
class WordDictionary {
    
    // 定义字典树数据结构
    private class WordTree {
        var children: [WordTree?]!
        var isEnd: Bool! // 是否为单词结尾
        init() {
            self.children = [WordTree?](repeating: nil, count: 26)
            self.isEnd = false
        }
    }
    
    
    private var start: WordTree!
    /**
     * Initialize your data structure here.
     */
    init() {
        self.start = WordTree()
    }
    
    func addWord(_ word: String) {
        var root: WordTree? = start
        for char in word {
            let index = Int(char.asciiValue!) - 97
            var node = root!.children[index]
            if root != nil && node == nil {
                node = WordTree()
                root!.children[index] = node
            }
            root = node
        }
        root?.isEnd = true
    }
    
    private func backTrack(_ word: String, _ index: Int, _ root: WordTree?) -> Bool {
        var root = root
        let wordArr = word.map({ $0 })
        for i in index..<word.count {
            let idx = Int(wordArr[i].asciiValue!) - 97
            if wordArr[i] != "." && root!.children[idx] == nil {
                return false
            }
            if wordArr[i] == "." {
                for j in 0..<26 {
                    if root!.children[j] == nil {
                        continue
                    } else if backTrack(word, i + 1, root!.children[j]) {
                        return true
                    }
                }
                return false
            }
            root = root!.children[idx]
        }
        return root!.isEnd
    }
    
    func search(_ word: String) -> Bool {
        let root = start
        return backTrack(word, 0, root)
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */
