//
//  TwentySix.swift
//  LeetCode
//
//  Created by UED on 2021/8/2.
//

import Foundation

class TwentySix {
    // 260. 只出现一次的数字 III
    func singleNumber(_ nums: [Int]) -> [Int] {
        var ret = 0
        for n in nums {
            ret ^= n
        }
        
        var div = 1
        while (div & ret) == 0 {
            div <<= 1
        }
        
        var a = 0, b = 0
        for n in nums {
            if (div & n) != 0 {
                a ^= n
            } else {
                b ^= n
            }
        }
        
        return [a, b]
    }
}
