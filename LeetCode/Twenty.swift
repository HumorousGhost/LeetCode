//
//  Twenty.swift
//  LeetCode
//
//  Created by UED on 2021/7/12.
//

import Foundation

class Twenty {
    // 200. 岛屿数量
    func numIslands(_ grid: [[Character]]) -> Int {
        var grid = grid
        func dfs(_ r: Int, _ c: Int) {
            let nr = grid.count
            let nc = grid[0].count
            
            if r < 0 || c < 0 || r >= nr || c >= nc || grid[r][c] == "0" {
                return
            }
            
            grid[r][c] = "0"
            dfs(r - 1, c)
            dfs(r + 1, c)
            dfs(r, c - 1)
            dfs(r, c + 1)
        }
        
        if grid.count == 0 {
            return 0
        }
        
        let nr = grid.count, nc = grid[0].count
        var numIslands = 0
        for r in 0..<nr {
            for c in 0..<nc {
                if grid[r][c] == "1" {
                    numIslands += 1
                    dfs(r, c)
                }
            }
        }
        
        return numIslands
    }
    
    // 201. 数字范围按位与
    func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
        var shift = 0, left = left, right = right
        // 找到公共前缀
        while left < right {
            left >>= 1
            right >>= 1
            shift += 1
        }
        return left << shift
    }
}
