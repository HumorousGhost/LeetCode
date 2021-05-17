//
//  Seven.swift
//  LeetCode
//
//  Created by UED on 2021/5/13.
//

import Cocoa

class Seven: NSObject {
    // 70. 爬楼梯
    func climbStairs(_ n: Int) -> Int {
        var p = 0, q = 0, r = 1
        for _ in 1...n {
            p = q
            q = r
            r = p + q
        }
        return r
    }
    
    // 71. 简化路径
    func simplifyPath(_ path: String) -> String {
        var stack = [String](repeating: "", count: 0) // 用栈来模拟
        let pathArr = path.split(separator: "/") // 用 / 分割，多个 / 也视为 /
        // 遍历
        for str in pathArr {
            // 如果等于 .. ，那就要返回上一级目录，因此栈中弹出当前目录
            // 此时栈可能是空
            if str == ".." {
                if !stack.isEmpty {
                    stack.removeLast()
                }
                continue
            } else if str == "." {
                continue
            }
            // 否则，栈中压入当前目录
            stack.append(String(str))
        }

        var string = ""
        // 使用的毕竟是数组，将数组循环
        for str in stack {
            string = string + "/" + str
        }
        if stack.count == 0 {
            string = "/"
        }
        return string
    }
    
    // 72. 编辑距离
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let n = word1.count
        let m = word2.count
        
        let word1Array = word1.map { String($0) }
        let word2Array = word2.map { String($0) }
        
        // 有一个字符串为空串
        if n * m == 0 {
            return n + m
        }
        
        // DP 数组
        var D = [[Int]](repeating: [Int](repeating: 0, count: m + 1), count: n + 1)
        
        // 边界状态初始化
        for i in 0...n {
            D[i][0] = i
        }
        for j in 0...m {
            D[0][j] = j
        }
        
        // 计算所有 DP 值
        for i in 1...n {
            for j in 1...m {
                let left = D[i - 1][j] + 1
                let down = D[i][j - 1] + 1
                var left_down = D[i - 1][j - 1]
                if word1Array[i - 1] != word2Array[j - 1] {
                    left_down += 1
                }
                D[i][j] = min(left, min(down, left_down))
            }
        }
        return D[n][m]
    }
    
    // 73. 矩阵置零
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        var row = [Bool](repeating: false, count: m)
        var column = [Bool](repeating: false, count: n)
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] == 0 {
                    row[i] = true
                    column[j] = true
                }
            }
        }
        for i in 0..<m {
            for j in 0..<n {
                if row[i] || column[j] {
                    matrix[i][j] = 0
                }
            }
        }
    }
    
    // 74. 搜索二维矩阵
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let length = matrix.count
        var index = -1
        for i in 0..<length {
            let value = matrix[i][0]
            if value == target {
                return true
            } else if value < target {
                index = i
            } else {
                break
            }
        }
        var columns = [Int]()
        if index > -1 {
            columns = matrix[index]
        }
        if columns.count == 0 {
            return false
        }
        var left = 0, right = columns.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if columns[mid] == target {
                return true
            } else if columns[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return false
    }
    
    // 75. 颜色分类
    func sortColors(_ nums: inout [Int]) {
        let length = nums.count
        var left = 0, right = length - 1
        for i in 0...right {
            while i <= right && nums[i] == 2 {
                let temp = nums[i]
                nums[i] = nums[right]
                nums[right] = temp
                right -= 1
            }
            if nums[i] == 0 {
                let temp = nums[i]
                nums[i] = nums[left]
                nums[left] = temp
                left += 1
            }
            if i == right {
                break
            }
        }
    }
    
    // 76. 最小覆盖子串
    func minWindow(_ s: String, _ t: String) -> String {
        
        var ori = [String : Int]()
        var cnt = [String : Int]()
        
        func check() -> Bool {
            for key in ori.keys {
                let val = ori[key]!
                if cnt[key] ?? 0 < val {
                    return false
                }
            }
            return true
        }
        
        for char in (t.map { String($0) }) {
            ori[char] = ori[char] != nil ? ori[char]! + 1 : 1
        }
        
        var l = 0, r = -1
        var len = Int.max
        var ansL = -1, ansR = -1
        
        let sArray = s.map { String($0) }
        let sLen = sArray.count
        while r < sLen {
            r += 1
            
            if r < sLen && ori[sArray[r]] ?? 0 > 0 {
                cnt[sArray[r]] = cnt[sArray[r]] != nil ? cnt[sArray[r]]! + 1 : 1
            }
            
            while check() && l <= r {
                if r - l + 1 < len {
                    len = r - l + 1
                    ansL = l
                    ansR = l + len
                }
                if ori[sArray[l]] ?? 0 > 0 {
                    cnt[sArray[l]] = cnt[sArray[l]]! - 1
                }
                l += 1
            }
        }
        
        return ansL == -1 ? "" : (s as NSString).substring(with: _NSRange.init(location: ansL, length: ansR - ansL))
    }
}
