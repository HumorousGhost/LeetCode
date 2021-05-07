//
//  Five.swift
//  LeetCode
//
//  Created by UED on 2021/5/6.
//

import Cocoa

class Five: NSObject {
    // 50. Pow(x, n)
    func myPow(_ x: Double, _ n: Int) -> Double {
        
        func quickMul(_ x: Double, _ N: inout Int) -> Double {
            if N < 0 {
                N = -N
            }
            var ans: Double = 1.0
            // 贡献的初始值为 x
            var x_contribute = x
            // 在对 N 进行二进制拆分的同时计算答案
            while N > 0 {
                if N % 2 == 1 {
                    // 如果 N 二进制表示的最低位为 1，那么需要计入贡献
                    ans *= x_contribute
                }
                // 将贡献不断的平方
                x_contribute *= x_contribute
                // 舍弃 N 二进制表示的最低位，这样我们每次只要判断最低位即可
                N /= 2
            }
            return ans
        }
        
        var N = n
        return N >= 0 ? quickMul(x, &N) : 1.0 / quickMul(x, &N)
    }
    
    // 51. N 皇后
    func solveNQueens(_ n: Int) -> [[String]] {
        
        func generateBoard(_ queens: [Int], _ n: Int) -> [String] {
            var board = [String].init(repeating: "", count: 0)
            for i in 0..<n {
                var row = [String](repeating: ".", count: n)
                row[queens[i]] = "Q"
                board.append(row.joined())
            }
            return board
        }
        
        func backtrack(_ solutions: inout [[String]], _ queens: inout [Int], _ n: Int, _ row: Int, _ columns: inout [Int], _ diagonals1: inout [Int], _ diagonals2: inout [Int]) {
            if row == n {
                let board = generateBoard(queens, n)
                solutions.append(board)
            } else {
                for i in 0..<n {
                    if columns.contains(i) {
                        continue
                    }
                    let diagonal1 = row - i
                    if diagonals1.contains(diagonal1) {
                        continue
                    }
                    let diagonal2 = row + i
                    if diagonals2.contains(diagonal2) {
                        continue
                    }
                    queens[row] = i
                    columns.append(i)
                    diagonals1.append(diagonal1)
                    diagonals2.append(diagonal2)
                    backtrack(&solutions, &queens, n, row + 1, &columns, &diagonals1, &diagonals2)
                    queens[row] = -1
                    columns.removeLast()
                    diagonals1.removeLast()
                    diagonals2.removeLast()
                }
            }
        }
        
        var solutions = [[String]].init(repeating: [String].init(repeating: "", count: 0), count: 0)
        var queens = [Int].init(repeating: -1, count: n)
        var columns = [Int].init(repeating: 0, count: 0)
        var diagonals1 = [Int].init(repeating: -1, count: 0)
        var diagonals2 = [Int].init(repeating: -1, count: 0)
        backtrack(&solutions, &queens, n, 0, &columns, &diagonals1, &diagonals2)
        return solutions
    }
    
    // 52. N 皇后 II
    func totalNQueens(_ n: Int) -> Int {
        
        func backtrack(_ n: Int, _ row: Int, _ columns: inout [Int], _ diagonals1: inout [Int], _ diagonals2: inout [Int]) -> Int {
            if row == n {
                return 1
            } else {
                var count = 0
                for i in 0..<n {
                    if columns.contains(i) {
                        continue
                    }
                    let diagonal1 = row - i
                    if diagonals1.contains(diagonal1) {
                        continue
                    }
                    let diagonal2 = row + i
                    if diagonals2.contains(diagonal2) {
                        continue
                    }
                    columns.append(i)
                    diagonals1.append(diagonal1)
                    diagonals2.append(diagonal2)
                    count += backtrack(n, row + 1, &columns, &diagonals1, &diagonals2)
                    columns.removeLast()
                    diagonals1.removeLast()
                    diagonals2.removeLast()
                }
                return count
            }
        }
        
        var columns = [Int].init(repeating: 0, count: 0)
        var diagonals1 = [Int].init(repeating: -1, count: 0)
        var diagonals2 = [Int].init(repeating: -1, count: 0)
        return backtrack(n, 0, &columns, &diagonals1, &diagonals2)
    }
    
    // 53. 最大子序和
    func maxSubArray(_ nums: [Int]) -> Int {
        var pre = 0, maxValue = nums.first!
        for x in nums {
            pre = max(pre + x, x)
            maxValue = max(maxValue, pre)
        }
        return maxValue
    }
}
