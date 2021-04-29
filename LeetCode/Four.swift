//
//  Four.swift
//  LeetCode
//
//  Created by UED on 2021/4/26.
//

import Cocoa

class Four: NSObject {
    // 41. 缺失的第一个正数
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var numsArray = nums
        let n = numsArray.count
        for i in 0..<n {
            if numsArray[i] <= 0 {
                numsArray[i] = n + 1
            }
        }
        for i in 0..<n {
            let num = abs(numsArray[i])
            if num <= n {
                numsArray[num - 1] = -abs(numsArray[num - 1])
            }
        }
        for i in 0..<n {
            if numsArray[i] > 0 {
                return i + 1
            }
        }
        return n + 1
    }
    
    // 42. 接雨水
    func trap(_ height: [Int]) -> Int {
        var ans = 0
        var left = 0, right = height.count - 1
        var leftMax = 0, rightMax = 0
        while left < right {
            leftMax = max(leftMax, height[left])
            rightMax = max(rightMax, height[right])
            if height[left] < height[right] {
                ans += leftMax - height[left];
                left += 1
            } else {
                ans += rightMax - height[right]
                right -= 1
            }
        }
        return ans
    }
    
    // 43. 字符串相乘
    func mutiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        if num1 == "1" {
            return num2
        }
        if num2 == "1" {
            return num1
        }
        
        let m = num1.count, n = num2.count
        var ansArr = [Int](repeating: 0, count: m + n)
        for valuei in 0...m - 1 {
            let i = m - 1 - valuei
            let x = ((num1 as NSString).substring(with: NSRange.init(location: i, length: 1)) as NSString).integerValue
            for valuej in 0...n - 1 {
                let j = n - 1 - valuej
                let y = ((num2 as NSString).substring(with: NSRange.init(location: j, length: 1)) as NSString).integerValue
                ansArr[i + j + 1] += x * y
            }
        }
        var i = m + n - 1
        while i > 0 {
            ansArr[i - 1] += ansArr[i] / 10
            ansArr[i] %= 10
            i -= 1
        }
        var index = ansArr[0] == 0 ? 1 : 0
        var ans = ""
        while index < m + n {
            ans.append(String(ansArr[index]))
            index += 1
        }
        return ans
    }
    
    // 44. 通配符匹配 1
    func isMatch(_ s: String, _ p: String) -> Bool {
        let m = s.count
        let n = p.count
        if n == 0 {
            return m == 0
        }
        
        let array = p.components(separatedBy: "*")
        var special = true
        for i in 0..<array.count {
            if array[i].count > 0 {
                special = false
            }
        }
        if m == 0 || special {
            return special
        }
        
        
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1)
        dp[0][0] = true
        for i in 1...n {
            if (p as NSString).substring(with: NSRange.init(location: i - 1, length: 1)) == "*" {
                dp[0][i] = true
            } else {
                break
            }
        }
        
        for i in 1...m {
            for j in 1...n {
                let pChar = (p as NSString).substring(with: _NSRange.init(location: j - 1, length: 1))
                let sChar = (s as NSString).substring(with: _NSRange.init(location: i - 1, length: 1))
                if pChar == "*" {
                    dp[i][j] = dp[i][j - 1] || dp[i - 1][j]
                } else if pChar == "?" || sChar == pChar {
                    dp[i][j] = dp[i - 1][j - 1]
                }
            }
        }
        return dp[m][n]
    }
    
    // 44. 通配符匹配 2 有问题
    func isMatch2(_ s: String, _ p: String) -> Bool {
        
        func allStars(str: String, left: Int, right: Int) -> Bool {
            for i in left..<right {
                if (str as NSString).substring(with: NSRange.init(location: i, length: 1)) != "*" {
                    return false
                }
            }
            return true
        }
        
        func charMatch(u: String, v: String) -> Bool {
            return u == v || v == "?"
        }
        
        if p == "*" {
            return true
        }
        
        var sRight = s.count, pRight = p.count
        while sRight > 0 && pRight > 0 && (p as NSString).substring(with: NSRange.init(location: pRight - 1, length: 1)) != "*" {
            if charMatch(u: (s as NSString).substring(with: NSRange.init(location: sRight - 1, length: 1)), v: (p as NSString).substring(with: NSRange.init(location: pRight - 1, length: 1))) {
                sRight -= 1
                pRight -= 1
            } else {
                return false
            }
        }
        
        if pRight == 0 {
            return sRight == 0
        }
        
        var sIndex = 0, pIndex = 0
        var sRecord = -1, pRecord = -1
        
        while sIndex < sRight && pIndex < sRight {
            if (p as NSString).substring(with: NSRange(location: pIndex, length: 1)) == "*" {
                pIndex += 1
                sRecord = sIndex
                pRecord = pIndex
            } else if charMatch(u: (s as NSString).substring(with: NSRange(location: sIndex, length: 1)), v: (p as NSString).substring(with: NSRange(location: pIndex, length: 1))) {
                sIndex += 1
                pIndex += 1
            } else if sRecord != -1 && sRecord + 1 < sRight {
                sRecord += 1
                sIndex = sRecord
                pIndex = pRecord
            } else {
                return false
            }
        }
        return allStars(str: p, left: pIndex, right: pRight)
    }
    
    // 45. 跳跃游戏 II
    func jump(_ nums: [Int]) -> Int {
        let length = nums.count
        var end = 0
        var maxPosition = 0
        var steps = 0
        for i in 0..<length - 1 {
            maxPosition = max(maxPosition, i + nums[i])
            if i == end {
                end = maxPosition
                steps += 1
            }
        }
        return steps
    }
    
    // 46. 全排列
    func permute(_ nums: [Int]) -> [[Int]] {
        
        func backtrack(_ n: Int, _ output: inout [Int], _ res: inout [[Int]], _ first: Int) {
            // 所有数都填完了
            if first == n {
                res.append(output)
            }
            for i in first..<n {
                // 动态维护数组
                output.swapAt(first, i)
                // 继续递归填下一个数
                backtrack(n, &output, &res, first + 1)
                // 撤销操作
                output.swapAt(first, i)
            }
        }
        
        var res = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        var output = [Int]()
        for num in nums {
            output.append(num)
        }
        
        let n = nums.count
        backtrack(n, &output, &res, 0)
        return res
    }
}
