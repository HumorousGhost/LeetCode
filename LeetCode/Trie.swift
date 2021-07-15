//
//  Trie.swift
//  LeetCode
//
//  Created by UED on 2021/7/14.
//

import Foundation

// 208. 实现 Trie (前缀树)
class Trie {
    
    private class TrieNode {
        var children: [TrieNode]!
        var value: Character?
        var isEnd: Bool!
        
        init(_ value: Character? = nil) {
            self.children = [];
            self.isEnd = false
            self.value = value
        }
        
        func getChild(_ child: Character) -> TrieNode? {
            self.children.first(where: { $0.value == child })
        }
        
        func push(_ node: TrieNode) {
            self.children.append(node)
        }
    }
    
    private var root: TrieNode!
    
    /** Initialize your data structure here. */
    init() {
        root = TrieNode()
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        var node = root
        for char in word {
            if let child = node?.getChild(char) {
                node = child
            } else {
                let childNode = TrieNode.init(char)
                node?.push(childNode)
                node = childNode
            }
        }
        node?.isEnd = true
    }
    
    private func searchPrefix(_ prefix: String) -> TrieNode? {
        var node = root
        for char in prefix {
            if let child = node?.getChild(char) {
                node = child
            } else {
                return nil
            }
        }
        return node
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        let node = searchPrefix(word)
        return node != nil && node!.isEnd
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        let node = searchPrefix(prefix)
        return node != nil
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * let obj = Trie()
 * obj.insert(word)
 * let ret_2: Bool = obj.search(word)
 * let ret_3: Bool = obj.startsWith(prefix)
 */
