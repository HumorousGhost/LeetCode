//
//  ThirtyFive.swift
//  LeetCode
//
//  Created by UED on 2021/10/18.
//

import Foundation

class ThirtyFive {
    // 350. 两个数组的交集 II
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.count > nums2.count {
            return intersect(nums2, nums1);
        }
        
        var map = [Int: Int]()
        for nums1 in nums1 {
            map[nums1, default: 0] += 1
        }
        
        var result = [Int]()
        for nums2 in nums2 {
            if let count = map[nums2], count > 0 {
                result.append(nums2);
                map[nums2]! -= 1
            }
        }
        
        return result
    }
}
