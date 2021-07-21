//
//  TwentyTwo.swift
//  LeetCode
//
//  Created by UED on 2021/7/21.
//

import Foundation

class TwentyTwo {
    // 220. 存在重复元素 II
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        
        func getID(_ x: Int, _ w: Int) -> Int {
            if x >= 0 {
                return x / w
            }
            return (x + 1) / w - 1
        }
        
        var map = [Int: Int]()
        for (index, num) in nums.enumerated() {
            let id = getID(num, t + 1)
            if let _ = map[id] {
                return true
            }
            if let x = map[id - 1], abs(num - x) <= t {
                return true
            }
            if let y = map[id + 1], abs(num - y) <= t {
                return true
            }
            map.updateValue(num, forKey: id)
            if index >= k {
                map.removeValue(forKey: getID(nums[index - k], t + 1))
            }
        }
        
        return false
    }
}
