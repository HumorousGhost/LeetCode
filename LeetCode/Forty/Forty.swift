//
//  Forty.swift
//  LeetCode
//
//  Created by UED on 2021/12/2.
//

import Foundation

class Forty {
    // 400. 第 N 位数字
    func findNthDigit(_ n: Int) -> Int {
        
        func totalDigits(_ length: Int) -> Int {
            var digits = 0, curLength = 1, curCount = 9
            while curLength <= length {
                digits += curLength * curCount
                curLength += 1
                curCount *= 10
            }
            return digits
        }
        
        var low = 1, high = 9
        while low < high {
            let mid = (high - low) / 2 + low
            if totalDigits(mid) < n {
                low = mid + 1
            } else {
                high = mid
            }
        }
        let d = low
        let prevDigits = totalDigits(d - 1)
        let index = n - prevDigits - 1
        let start = Int(pow(10.0, Double(d - 1)))
        let num = start + index / d
        let digitIndex = index % d
        let digit = (num / Int(pow(10.0, Double(d - digitIndex - 1)))) % 10
        return digit
    }
    
    // 401. 二进制手表
    func readBinaryWatch(_ turnedOn: Int) -> [String] {
        var ans = [String]()
        for h in 0..<12 {
            for m in 0..<60 {
                if h.nonzeroBitCount + m.nonzeroBitCount == turnedOn {
                    ans.append("\(h):\(m < 10 ? "0" : "")\(m)")
                }
            }
        }
        return ans
    }
    
    // 402. 移掉 K 位数字
    func removeKdigits(_ num: String, _ k: Int) -> String {
        var k = k
        var deque = [Character]()
        for digit in num {
            while !deque.isEmpty && k > 0 && deque.last! > digit {
                deque.removeLast()
                k -= 1
            }
            deque.append(digit)
        }
        
        for _ in 0..<k {
            deque.removeLast()
        }
        
        var ret = ""
        var leadingZero = true
        while !deque.isEmpty {
            let digit = deque.removeFirst()
            if leadingZero && digit == "0" {
                continue
            }
            leadingZero = false
            ret.append(digit)
        }
        return ret.count == 0 ? "0" : ret
    }
    
    // 403. 青蛙过河
    func canCross(_ stones: [Int]) -> Bool {
        var dict = [Int: Int]()
        for (index, value) in stones.enumerated() {
            dict[value] = index
        }
        
        var dp = [Set<Int>](repeating: Set<Int>(), count: stones.count)
        dp[0] = [0]
        for i in 0..<stones.count {
            for k in dp[i] {
                if let index = dict[stones[i] + k - 1], index > i, k - 1 > 0 {
                    dp[index].insert(k - 1)
                }
                if let index = dict[stones[i] + k] {
                    dp[index].insert(k)
                }
                if let index = dict[stones[i] + k + 1] {
                    dp[index].insert(k + 1)
                }
            }
        }
        return !dp.removeLast().isEmpty
    }
    
    // 404. 左叶子之和
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        
        var ans = 0
        
        func dfs(_ root: TreeNode?) {
            guard let root = root else {
                return
            }
            
            if let right = root.right {
                dfs(right)
            }
            
            if let left = root.left, left.left == nil && left.right == nil {
                ans += left.val
                return
            }
            dfs(root.left)
        }
        
        dfs(root)
        
        return ans
    }
    
    // 405. 数字转换为十六进制数
    func toHex(_ num: Int) -> String {
        
        func getHexString(_ n: Int) -> Character {
            switch n {
            case 10:
                return "a"
            case 11:
                return "b"
            case 12:
                return "c"
            case 13:
                return "d"
            case 14:
                return "e"
            case 15:
                return "f"
            default:
                return Character("\(n)")
            }
        }
        
        guard num != 0 else {
            return "0"
        }
        
        var num = num
        var ans = ""
        if num < 0 {
            num = Int(pow(2.0, 32.0)) + num
        }
        while num != 0 {
            let u = num % 16
            ans.insert(getHexString(u), at: ans.startIndex)
            num /= 16
        }
        
        return ans
    }
}
