//
//  NumArray.swift
//  LeetCode
//
//  Created by UED on 2021/8/11.
//

import Foundation

// 303. 区域和检索 - 数组不可变
class NumArray {
    
    var array: [Int]
    
    init(_ nums: [Int]) {
        array = nums
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
        let nums = array[left...right]
        var num = 0
        for n in nums {
            num += n
        }
        return num
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * let obj = NumArray(nums)
 * let ret_1: Int = obj.sumRange(left, right)
 */
