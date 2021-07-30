//
//  TwentyFour.swift
//  LeetCode
//
//  Created by UED on 2021/7/30.
//

import Foundation

class TwentyFour {
    // 240. 搜索二维矩阵 II
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let n = matrix[0].count
        var list = [Int]()
        for (index, value) in matrix.enumerated() {
            if value[0] == target || target == value[n - 1] {
                return true
            } else if value[0] < target && target < value[n - 1] {
                list.append(index)
            }
        }
        
        for i in list {
            let nums = matrix[i]
            var left = 0, right = n - 1, mid = (left + right) / 2
            while left <= right {
                if nums[mid] == target {
                    return true
                } else if target < nums[mid] {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
                mid = (left + right) / 2
            }
        }
        
        return false
    }
}
