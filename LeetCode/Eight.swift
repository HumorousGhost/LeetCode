//
//  Eight.swift
//  LeetCode
//
//  Created by UED on 2021/5/18.
//

import Cocoa

class Eight: NSObject {
    // 80. 删除有序数组中的重复项 II
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var map = [Int: Int]()
        var i = nums.count - 1
        while i >= 0 {
            let value = nums[i]
            map[value] = map[value] != nil ? map[value]! + 1 : 1
            if map[value]! > 2 {
                nums.remove(at: i)
            }
            i -= 1
        }
        return nums.count
    }
}
