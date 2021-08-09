//
//  TwentyEight.swift
//  LeetCode
//
//  Created by UED on 2021/8/5.
//

import Foundation

class TwentyEight {
    // 282. 给表达式添加运算符
    func addOperators(_ num: String, _ target: Int) -> [String] {
        
        var result = [String]()
        let numStr = num.map({String($0)})
        let count = num.count
        
        func help(_ curRes: Int, _ diff: Int, _ start: Int, _ curExp: String) {
            if start == count && target == curRes {
                result.append(curExp)
            }
            
            for i in start..<count {
                let curArr = numStr[start..<i + 1]
                if curArr.count > 1 && curArr.first == "0" {
                    break
                }
                
                let cur = curArr.joined()
                
                if curExp.count > 0 {
                    help(curRes + Int(cur)!, Int(cur)!, i + 1, curExp + "+" + cur)
                    help(curRes - Int(cur)!, -Int(cur)!, i + 1, curExp + "-" + cur)
                    help((curRes - diff) + (diff * Int(cur)!), diff * Int(cur)!, i + 1, curExp + "*" + cur)
                } else {
                    help(Int(cur)!, Int(cur)!, i + 1, cur)
                }
            }
        }
        
        if num.count == 0 {
            return result
        }
        
        help(0, 0, 0, "")
        
        return result
    }
    
    // 283. 移动零
    func moveZeroes(_ nums: inout [Int]) {
        let count = nums.count
        var i = 0
        var index = 0
        while i < count && index < count {
            let num = nums[i]
            if num == 0 {
                nums.remove(at: i)
                nums.append(num)
            } else {
                i += 1
            }
            index += 1
        }
    }
    
    // 287. 寻找重复数
    func findDuplicate(_ nums: [Int]) -> Int {
        var slow = 0, fast = 0
        slow = nums[slow]
        fast = nums[nums[fast]]
        while slow != fast {
            slow = nums[slow]
            fast = nums[nums[fast]]
        }
        slow = 0
        while slow != fast {
            slow = nums[slow]
            fast = nums[fast]
        }
        return slow
    }
    
    // 289. 生命游戏
    func gameOfLife(_ board: inout [[Int]]) {
        let neighbors = [0, 1, -1]
        
        let rows = board.count
        let cols = board[0].count
        
        // 创建复制数组 copyBoard
        let copyBoard = board
        
        // 遍历面板每一个格子里的细胞
        for row in 0..<rows {
            for col in 0..<cols {
                // 对于每一个细胞统计其八个相邻位置里的活细胞数量
                var liveNeighbors = 0
                
                for i in 0..<3 {
                    for j in 0..<3 {
                        if !(neighbors[i] == 0 && neighbors[j] == 0) {
                            let r = row + neighbors[i]
                            let c = col + neighbors[j]
                            
                            // 查看相邻的细胞是否是活细胞
                            if r < rows && r >= 0 && c < cols && c >= 0 && copyBoard[r][c] == 1 {
                                liveNeighbors += 1
                            }
                        }
                    }
                }
                
                // 规则 1 或规则 3
                if copyBoard[row][col] == 1 && (liveNeighbors < 2 || liveNeighbors > 3) {
                    board[row][col] = 0
                }
                
                // 规则 4
                if copyBoard[row][col] == 0 && liveNeighbors == 3 {
                    board[row][col] = 1
                }
            }
        }
    }
}
