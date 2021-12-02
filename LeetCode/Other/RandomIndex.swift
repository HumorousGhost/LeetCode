//
//  RandomIndex.swift
//  LeetCode
//
//  Created by UED on 2021/11/30.
//

import Foundation

// 398. 随机数索引
class RandomIndex {
    
    private var map = [Int: [Int]]()
    
    init(_ nums: [Int]) {
        for (index, value) in nums.enumerated() {
            map[value, default: [Int]()].append(index)
        }
    }
    
    func pick(_ target: Int) -> Int {
        guard let indexs = map[target] else {
            return 0
        }
        return indexs[Int.random(in: 0..<indexs.count)]
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: Int = obj.pick(target)
 */
