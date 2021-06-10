//
//  Thirteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/10.
//

import Cocoa

class Thirteen: NSObject {
    // 130. 被围绕的区域
    func solve(_ board: inout [[Character]]) {
        let n = board.count
        if n == 0 {
            return
        }
        let m = board[0].count
        if m <= 1 {
            return
        }
        
        func dfs(_ x: Int, _ y: Int) {
            if x < 0 || x >= n || y < 0 || y >= m || board[x][y] != "O" {
                return
            }
            board[x][y] = "A"
            dfs(x + 1, y)
            dfs(x - 1, y)
            dfs(x, y + 1)
            dfs(x, y - 1)
        }
        
        for i in 0..<n {
            dfs(i, 0)
            dfs(i, m - 1)
        }
        for i in 1..<m - 1 {
            dfs(0, i)
            dfs(n - 1, i)
        }
        
        for i in 0..<n {
            for j in 0..<m {
                if board[i][j] == "A" {
                    board[i][j] = "O"
                } else if (board[i][j] == "O") {
                    board[i][j] = "X"
                }
            }
        }
    }
}
