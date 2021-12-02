//
//  RandomizedCollection.swift
//  LeetCode
//
//  Created by UED on 2021/11/4.
//

import Foundation

// 381. O(1) 时间插入、删除和获取随机元素 - 允许重复
class RandomizedCollection {

    var dict: [Int: Int]
    var sum: Int

    /** Initialize your data structure here. */
    init() {
        dict = [Int: Int]()
        sum = 0
    }
        
    /** Inserts a value to the collection. Returns true if the collection did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        sum = sum + 1
        dict[val, default: 0] += 1
        return dict[val]! == 1
    }
        
    /** Removes a value from the collection. Returns true if the collection contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let _ = dict[val] else {
            return false
        }
        sum -= 1
        dict[val]! -= 1
        if dict[val] == 0 {
            dict.removeValue(forKey: val)
        }
        return true
    }
        
    /** Get a random element from the collection. */
    func getRandom() -> Int {
        guard sum > 0 else {
            return 0
        }
        
        let r = Int.random(in: 0..<sum)

        var index = 0
        for (num, count) in dict {
            index = index + count
            if index - 1 >= r {
                return num
            }
        }
        return 0
    }
}

/**
 * Your RandomizedCollection object will be instantiated and called as such:
 * let obj = RandomizedCollection()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */
