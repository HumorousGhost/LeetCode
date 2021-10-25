//
//  ThirtySix.swift
//  LeetCode
//
//  Created by UED on 2021/10/22.
//

import Foundation

class ThirtySix {
    // 363. 矩形区域不超过 K 的最大数值和
    func maxSumSubmatrix(_ matrix: [[Int]], _ k: Int) -> Int {
        
        func dpMax(_ arr: [Int], _ k: Int) -> Int {
            var result = Int.min
            for l in arr.indices {
                var sum = 0
                for r in l..<arr.count {
                    sum += arr[r]
                    if sum > result && sum <= k {
                        result = sum
                    }
                }
            }
            return result
        }
        
        var maxNum = Int.min
        for col in matrix[0].indices {
            var rowSum = [Int](repeating: 0, count: matrix.count)
            for row in col..<matrix[0].count {
                for i in matrix.indices {
                    rowSum[i] += matrix[i][row]
                }
                maxNum = max(maxNum, dpMax(rowSum, k))
            }
        }
        return maxNum
    }
    
    // 365. 水壶问题
    func canMeasureWater(_ jug1Capacity: Int, _ jug2Capacity: Int, _ targetCapacity: Int) -> Bool {
        
        func gcd(_ x: Int, _ y: Int) -> Int {
            var x = x, y = y
            var remainder = x % y
            while remainder != 0 {
                x = y
                y = remainder
                remainder = x % y
            }
            return y
        }
        
        if jug1Capacity + jug2Capacity < targetCapacity {
            return false
        }
        if jug1Capacity == 0 || jug2Capacity == 0 {
            return targetCapacity == 0 || jug1Capacity + jug2Capacity == targetCapacity
        }
        return targetCapacity % gcd(jug1Capacity, jug2Capacity) == 0
    }
    
    // 367. 有效的完全平方数
    func isPerfectSquare(_ num: Int) -> Bool {
        guard num > 1 else {
            return true
        }
        var maxNum = num
        var s = 2
        while s < maxNum {
            if s * s == num {
                return true
            }
            maxNum = num / s
            s += 1
        }
        return false
    }
}
