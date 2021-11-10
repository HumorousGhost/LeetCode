//
//  ShuffleTheArray.swift
//  LeetCode
//
//  Created by UED on 2021/11/9.
//

import Foundation

// 384. 打乱数组
class ShuffleTheArray {
    
    let nums: [Int]
    
    init(_ nums: [Int]) {
        self.nums = nums
    }
        
    func reset() -> [Int] {
        return nums
    }
        
    func shuffle() -> [Int] {
        var temp = nums
        var result = [Int]()
        while result.count != nums.count {
            let index = Int.random(in: 0..<temp.count)
            let num = temp.remove(at: index)
            result.append(num)
        }
        return result
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: [Int] = obj.reset()
 * let ret_2: [Int] = obj.shuffle()
 */
