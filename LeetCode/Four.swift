//
//  Four.swift
//  LeetCode
//
//  Created by UED on 2021/4/26.
//

import Cocoa

class Four: NSObject {
    // 41. 缺失的第一个正数
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var numsArray = nums
        let n = numsArray.count
        for i in 0..<n {
            if numsArray[i] <= 0 {
                numsArray[i] = n + 1
            }
        }
        for i in 0..<n {
            let num = abs(numsArray[i])
            if num <= n {
                numsArray[num - 1] = -abs(numsArray[num - 1])
            }
        }
        for i in 0..<n {
            if numsArray[i] > 0 {
                return i + 1
            }
        }
        return n + 1
    }
}
