//
//  TwentyTwo.swift
//  LeetCode
//
//  Created by UED on 2021/7/21.
//

import Foundation

class TwentyTwo {
    // 220. 存在重复元素 II
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        
        func getID(_ x: Int, _ w: Int) -> Int {
            if x >= 0 {
                return x / w
            }
            return (x + 1) / w - 1
        }
        
        var map = [Int: Int]()
        for (index, num) in nums.enumerated() {
            let id = getID(num, t + 1)
            if let _ = map[id] {
                return true
            }
            if let x = map[id - 1], abs(num - x) <= t {
                return true
            }
            if let y = map[id + 1], abs(num - y) <= t {
                return true
            }
            map.updateValue(num, forKey: id)
            if index >= k {
                map.removeValue(forKey: getID(nums[index - k], t + 1))
            }
        }
        
        return false
    }
    
    // 221. 最大正方形
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        var maxSide = 0
        if matrix.count == 0 || matrix[0].count == 0 {
            return maxSide
        }
        let rows = matrix.count, columns = matrix[0].count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: columns), count: rows)
        for i in 0..<rows {
            for j in 0..<columns {
                if matrix[i][j] == "1" {
                    if i == 0 || j == 0 {
                        dp[i][j] = 1
                    } else {
                        dp[i][j] = min(min(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1]) + 1
                    }
                    maxSide = max(maxSide, dp[i][j])
                }
            }
        }
        return maxSide * maxSide
    }
    
    // 222. 完全二叉树的节点个数
    func countNodes(_ root: TreeNode?) -> Int {
        var result = 0
        
        func getNode(_ root: TreeNode?) {
            if root == nil {
                return
            }
            result += 1
            getNode(root?.left)
            getNode(root?.right)
        }
        
        getNode(root)
        
        return result
    }
    
    // 223. 矩形面积
    func computeArea(_ ax1: Int, _ ay1: Int, _ ax2: Int, _ ay2: Int, _ bx1: Int, _ by1: Int, _ bx2: Int, _ by2: Int) -> Int {
        
        let x1 = max(ax1, bx1)
        let y1 = max(ay1, by1)
        let x2 = min(ax2, bx2)
        let y2 = min(ay2, by2)
        let area = (x2 - x1) * (y2 - y1)
        
        let a = (ax2 - ax1) * (ay2 - ay1)
        let b = (bx2 - bx1) * (by2 - by1)
        
        
        return a + b - (ay1 >= by2 || ax2 <= bx1 || ay2 <= by1 || ax1 >= bx2 ? 0 : area)
    }
    
    // 224. 基本计算器
    func calculate(_ s: String) -> Int {
        // ops：栈数组，sign：正负标识，num：数字容器，result：结果
        // 栈数组用来存储当前 结果以及符号
        var ops = [Int](), sign = 1, num = "", result = 0
        
        // 用来计算
        func calNum(_ char: String) {
            result += Int(char) ?? 0 * sign
            num = ""
        }
        
        // 定义 temp 为去除空格字符串之后的 s
        let temp = s.replacingOccurrences(of: " ", with: "")
        
        // 循环 temp
        for char in temp {
            if char == "(" {
                // 先求和
                calNum(num)
                // 存之前的和
                ops.append(result)
                // 存当前符号
                ops.append(sign)
                result = 0
                sign = 1
            } else if char == ")" {
                // 求和
                calNum(num)
                // 乘之前的符号
                result *= ops.removeLast()
                // 加上之前的和
                result += ops.removeLast()
            } else if char == "+" {
                calNum(num)
                sign = 1
            } else if char == "-" {
                calNum(num)
                sign = -1
            } else {
                // 如果是数字，num依次拼接
                num.append(char)
            }
        }
        
        // 循环结束，求最后的和
        calNum(num)
        
        return result
    }
    
    // 226. 翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        
        func invert(_ root: TreeNode?) {
            if root == nil {
                return
            }
            let temp = root?.left
            root?.left = root?.right
            root?.right = temp
            invert(root?.left)
            invert(root?.right)
        }
        
        invert(root)
        return root
    }
    
    // 227. 基本计算器 II
    func calculate2(_ s: String) -> Int {
        var stack = [Int]()
        
        var num = 0
        var operation = "+"

        for c in s + "+" {
            guard c != " " else { continue }
            if c.isNumber {
                num = num * 10 + Int(String(c))!
            } else {
                switch operation {
                    case "+":
                        stack.append(num)
                    case "-":
                        stack.append(-num)
                    case "*":
                        stack.append(stack.popLast()! * num)
                    case "/":
                        stack.append(stack.popLast()! / num)
                    default:
                        break
                }
                operation = String(c)
                num = 0
            }
        }

        var res = 0
        for item in stack {
            res += item
        }
        return res
    }
    
    // 228. 汇总区间
    func summaryRanges(_ nums: [Int]) -> [String] {
        var ans = [String]()
        var i = 0
        let n = nums.count
        while i < n {
            let low = i
            i += 1
            while i < n && nums[i] == nums[i - 1] + 1 {
                i += 1
            }
            let high = i - 1
            var temp = "\(nums[low])"
            if low < high {
                temp.append("->\(nums[high])")
            }
            ans.append(temp)
        }
        
        return ans
    }
}
