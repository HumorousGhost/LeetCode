//
//  MedianFinder.swift
//  LeetCode
//
//  Created by UED on 2021/8/10.
//

import Foundation

// 295. 数据流的中位数
class MedianFinder {
    
    var nums: [Int]
    
    /** initialize your data structure here. */
    init() {
        nums = [Int]()
    }
    
    func addNum(_ num: Int) {
        if nums.count == 0 {
            nums.append(num)
            return
        }
        var left = 0, right = nums.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if nums[mid] < num {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        nums.insert(num, at: left)
    }
    
    func findMedian() -> Double {
        let length = nums.count
        let i = length / 2
        let left = nums[i]
        var right = 0
        if length % 2 == 0 {
            right = nums[i - 1]
        } else {
            right = left
        }
        return Double(left + right) / 2.0
    }
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * let obj = MedianFinder()
 * obj.addNum(num)
 * let ret_2: Double = obj.findMedian()
 */
