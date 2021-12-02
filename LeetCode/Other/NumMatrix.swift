//
//  NumMatrix.swift
//  LeetCode
//
//  Created by UED on 2021/8/13.
//

import Foundation

// 304. 二维区域和检索 - 矩阵不可变
class NumMatrix {
    
    var sum: [[Int]]
    
    init(_ matrix: [[Int]]) {
        let r = matrix.count
        let c = matrix[0].count
        sum = [[Int]](repeating: [Int](repeating: 0, count: c + 1), count: r + 1)
        for i in 1...r {
            for j in 1...c {
                sum[i][j] = sum[i - 1][j] + sum[i][j - 1] + matrix[i - 1][j - 1] - sum[i - 1][j - 1]
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        return sum[row2 + 1][col2 + 1] + sum[row1][col1] - sum[row2 + 1][col1] - sum[row1][col2 + 1]
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */
