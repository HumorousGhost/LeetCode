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
}
