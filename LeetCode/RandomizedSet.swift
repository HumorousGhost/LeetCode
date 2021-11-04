//
//  RandomizedSet.swift
//  LeetCode
//
//  Created by UED on 2021/11/3.
//

import Foundation

// 380. O(1)时间插入、删除和获取随机元素
class RandomizedSet {

    var list: [Int]
    var dict: [Int: Int]
    
    init() {
        list = [Int]()
        dict = [Int: Int]()
    }
    
    func insert(_ val: Int) -> Bool {
        if let _ = dict[val] {
            return false
        }
        dict[val] = list.count
        list.append(val)
        return true
    }
    
    func remove(_ val: Int) -> Bool {
        guard let index = dict[val] else {
            return false
        }
        
        if index != list.count - 1 {
            let lastVal = list.last!
            dict[lastVal] = index
            list.swapAt(index, list.count - 1)
        }
        list.removeLast()
        dict.removeValue(forKey: val)
        return true
    }
    
    func getRandom() -> Int {
        return list[Int.random(in: 0..<list.count)]
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */
