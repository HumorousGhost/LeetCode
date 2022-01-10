//
//  FortyOne.swift
//  LeetCode
//
//  Created by UED on 2021/12/27.
//

import Foundation

class FortyOne {
    // 410. 分割数组的最大值
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        let n = nums.count
        var f = [[Int]](repeating: [Int](repeating: Int.max, count: m + 1), count: n + 1)
        var sub = [Int](repeating: 0, count: n + 1)
        for i in 0..<n {
            sub[i + 1] = sub[i] + nums[i]
        }
        f[0][0] = 0
        for i in 1...n {
            for j in 1...min(i, m) {
                for k in 0..<i {
                    f[i][j] = min(f[i][j], max(f[k][j - 1], sub[i] - sub[k]))
                }
            }
        }
        return f[n][m]
    }
    
    // 412. Fizz Buzz
    func fizzBuzz(_ n: Int) -> [String] {
        var ans = [String]()
        for i in 0..<n {
            if (i + 1) % 3 == 0 && (i + 1) % 5 == 0 {
                ans.append("FizzBuzz")
            } else if (i + 1) % 3 == 0 {
                ans.append("Fizz")
            } else if (i + 1) % 5 == 0 {
                ans.append("Buzz")
            } else {
                ans.append("\(i + 1)")
            }
        }
        return ans
    }
    
    // 413. 等差数列划分
    func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
        guard nums.count > 2 else {
            return 0
        }
        
        var d = nums[0] - nums[1], t = 0
        var ans = 0
        // 因为等差数列的长度至少为 3，所以可以从 i = 2 开始枚举
        for i in 2..<nums.count {
            if nums[i - 1] - nums[i] == d {
                t += 1
            } else {
                d = nums[i - 1] - nums[i]
                t = 0
            }
            ans += t
        }
        return ans
    }
    
    // 414. 第三大的数
    func thirdMax(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
        for num in nums {
            map[num, default: 0] += 1
        }
        let sortNums = map.keys.sorted()
        if sortNums.count >= 3 {
            return sortNums[sortNums.count - 3]
        } else {
            return sortNums.last!
        }
    }
    
    // 415. 字符串相加
    func addStrings(_ num1: String, _ num2: String) -> String {
        
        guard num1.count > 0 && num2.count > 0 else {
            return num1.count == 0 ? num2 : num1
        }
        
        var maxNum: [Character]
        var minNum: [Character]
        if num1.count > num2.count {
            maxNum = num1.map({$0})
            minNum = num2.map({$0})
        } else {
            maxNum = num2.map({$0})
            minNum = num1.map({$0})
        }
        
        let lengthDiff = maxNum.count - minNum.count
        var carry = 0
        let num0 = Character("0").asciiValue!
        var ans = [String]()
        for i in (0..<maxNum.count).reversed() {
            let j = i - lengthDiff
            let tempMin = j >= 0 ? minNum[j] : "0"
            let num = Int(maxNum[i].asciiValue! - num0 + tempMin.asciiValue! - num0) + carry
            if num >= 10 {
                carry = num / 10
                ans.append("\(num % 10)")
            } else {
                ans.append("\(num)")
                carry = 0
            }
        }
        if carry > 0 {
            ans.append("\(carry)")
        }
        
        return ans.reversed().joined()
    }
    
    // 416. 分割等和子集
    func canPartition(_ nums: [Int]) -> Bool {
        guard nums.count >= 2 else {
            return false
        }
        
        var sum = 0, maxNum = 0
        for num in nums {
            sum += num
            maxNum = max(maxNum, num)
        }
        if sum % 2 != 0 {
            return false
        }
        
        let target = sum / 2
        if maxNum > target {
            return false
        }
        var dp = [Bool](repeating: false, count: target + 1)
        dp[0] = true
        for num in nums {
            for j in (num...target).reversed() {
                dp[j] = dp[j] || dp[j - num]
            }
        }
        
        return dp[target]
    }
    
    // 417. 太平洋大西洋水流问题
    func pacificAtlantic(_ heights: [[Int]]) -> [[Int]] {
        
        let rows = heights.count
        guard rows > 0 else {
            return []
        }
        let cols = heights[0].count
        
        let rowsRange = 0..<rows
        let colsRange = 0..<cols
        
        enum DFSState {
            case clear(_ row: Int, _ col: Int)
            case topMapped(_ row: Int, _ col: Int)
            case bottomMapped(_ row: Int, _ col: Int)
            case leftMapped(_ row: Int, _ col: Int)
            case rightMapped(_ row: Int, _ col: Int)
        }
        
        var flows = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
        var result = [[Int]]()
        
        let dfs: (Int, Int) -> Void = { (row, col) in
            var positions = [DFSState.clear(row, col)]
            while let last = positions.last {
                switch last {
                case let .clear(row, col):
                    positions[positions.count - 1] = .topMapped(row, col)
                    if rowsRange ~= row - 1,
                       heights[row - 1][col] >= heights[row][col],
                       flows[row - 1][col] | flows[row][col] > flows[row - 1][col] {
                        flows[row - 1][col] = flows[row - 1][col] | flows[row][col]
                        positions.append(.clear(row - 1, col))
                    }
                    break
                case let .topMapped(row, col):
                    positions[positions.count - 1] = .bottomMapped(row, col)
                    if rowsRange ~= row + 1, heights[row + 1][col] >= heights[row][col], flows[row + 1][col] | flows[row][col] > flows[row + 1][col] {
                        flows[row + 1][col] = flows[row + 1][col] | flows[row][col]
                        positions.append(.clear(row + 1, col))
                    }
                    break
                case let .bottomMapped(row, col):
                    positions[positions.count - 1] = .leftMapped(row, col)
                    if colsRange ~= col - 1, heights[row][col - 1] >= heights[row][col], flows[row][col - 1] | flows[row][col] > flows[row][col - 1] {
                        flows[row][col - 1] = flows[row][col - 1] | flows[row][col]
                        positions.append(.clear(row, col - 1))
                    }
                    break
                case let .leftMapped(row, col):
                    positions[positions.count - 1] = .rightMapped( row,  col)
                    if colsRange ~= col + 1, heights[row][col + 1] >= heights[row][col], flows[row][col + 1] | flows[row][col] > flows[row][col + 1] {
                        flows[row][col + 1] = flows[row][col + 1] | flows[row][col]
                        positions.append(.clear(row, col + 1))
                    }
                    break
                case let .rightMapped(row, col):
                    if flows[row][col] == 3 { result.append([row, col])
                    }
                    positions.removeLast()
                    break
                }
            }
        }
        
        for row in rowsRange {
            if flows[row][0] | 1 > flows[row][0] {
                flows[row][0] = flows[row][0] | 1
                dfs(row, 0)
            }
            
            if flows[row][cols - 1] | 2 > flows[row][cols - 1] {
                flows[row][cols - 1] = flows[row][cols - 1] | 2
                dfs(row, cols - 1)
            }
        }
        
        for col in colsRange {
            if flows[0][col] | 1 > flows[0][col] {
                flows[0][col] = flows[0][col] | 1
                dfs(0, col)
            }
                
            if flows[rows - 1][col] | 2 > flows[rows - 1][col] {
                flows[rows - 1][col] = flows[rows - 1][col] | 2
                dfs(rows - 1, col)
            }
        }
        return result
    }
    
    // 419. 甲板上的战舰
    func countBattleships(_ board: [[Character]]) -> Int {
        let row = board.count
        let col = board[0].count
        var ans = 0
        for i in 0..<row {
            for j in 0..<col {
                if board[i][j] == "X" {
                    if i > 0 && board[i - 1][j] == "X" {
                        continue
                    }
                    if j > 0 && board[i][j - 1] == "X" {
                        continue
                    }
                    ans += 1
                }
            }
        }
        return ans
    }
}
