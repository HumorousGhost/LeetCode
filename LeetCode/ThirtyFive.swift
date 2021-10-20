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
    
    // 354. 俄罗斯套娃信封问题
    func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        guard envelopes.count > 0 else {
            return 0
        }
        let newEnvelopes = envelopes.sorted { e1, e2 in
            return e1[0] < e2[0] || (e1[0] == e2[0] && e1[1] > e2[1])
        }
        var maxLength = 1
        var lengths = [Int](repeating: 1, count: newEnvelopes.count)
        
        for i in 0..<newEnvelopes.count {
            for j in 0..<i {
                if newEnvelopes[i][1] > newEnvelopes[j][1] {
                    lengths[i] = max(lengths[i], lengths[j] + 1);
                }
            }
            maxLength = max(lengths[i], maxLength);
        }
        return maxLength
    }
}
