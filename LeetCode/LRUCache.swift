//
//  LRUCache.swift
//  LeetCode
//
//  Created by UED on 2021/6/18.
//

import Foundation

// 146. LRU 缓存机制
class LRUCache {
    
    var capacity: Int
    var dic: [Int: Int]
    var keys: [Int]
    
    init(_ capacity: Int) {
        self.capacity = capacity
        self.dic = [Int: Int]()
        self.keys = [Int]()
    }
    
    func get(_ key: Int) -> Int {
        if keys.contains(key) {
            let temp = NSMutableArray.init(array: self.keys)
            temp.remove(key)
            self.keys = temp as! [Int]
            self.keys.append(key)
        }
        return dic[key] ?? -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if keys.count < self.capacity {
            self.dic[key] = value
            self.keys.append(key)
        } else {
            let firstKey = self.keys.removeFirst()
            self.dic.removeValue(forKey: firstKey)
            self.dic[key] = value
            self.keys.append(key)
        }
    }
    
}
