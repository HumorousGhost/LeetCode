//
//  ThirtyThree.swift
//  LeetCode
//
//  Created by UED on 2021/9/9.
//

import Foundation

class ThirtyThree {
    // 330. 按要求补齐数组
    func minPatches(_ nums: [Int], _ n: Int) -> Int {
        var patches = 0
        var x = 1, index = 0
        let length = nums.count
        while x <= n {
            if index < length && nums[index] <= x {
                x += nums[index]
                index += 1
            } else {
                x *= 2
                patches += 1
            }
        }
        return patches
    }
}
