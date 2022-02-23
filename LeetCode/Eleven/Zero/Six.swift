//
//  Six.swift
//  LeetCode
//
//  Created by UED on 2021/5/10.
//

import Cocoa

class Six {
    // 60. 排列序列
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var factorial = [Int](repeating: 0, count: n)
        factorial[0] = 1
        // n!
        for i in 1..<n {
            factorial[i] = factorial[i - 1] * i
        }
        var kValue = k - 1
        var ans = ""
        var valid = [Int](repeating: 1, count: n + 1)
        for i in 1...n {
            var order = kValue / factorial[n - i] + 1
            for j in 1...n {
                order -= valid[j]
                if order == 0 {
                    ans.append(String(j))
                    valid[j] = 0
                    break
                }
            }
            kValue %= factorial[n - i]
        }
        return ans
    }
    
    // 61. 旋转链表
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        if k == 0 || head == nil || head?.next == nil {
            return head
        }
        var n = 1
        var iter = head
        // 获取链表长度
        while iter?.next != nil {
            iter = iter?.next
            n += 1
        }
        var add = n - k % n
        // 判断旋转个数与链表长度是否相同
        if add == n {
            return head
        }
        // 形成闭环
        iter?.next = head
        // 获取到应为旋转后的首个节点
        while add > 0 {
            add -= 1
            iter = iter?.next
        }
        // 解除闭环
        let ret = iter?.next
        iter?.next = nil
        return ret
    }
    
    // 62. 不同路径
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var ans = 1
        var x = n, y = 1
        while y < m {
            ans = ans * x / y
            x += 1
            y += 1
        }
        return ans
    }
    
    // 63. 不同路径 II
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
//        var steps = [[Int]](repeating: [Int](repeating: 0, count: obstacleGrid[0].count), count: obstacleGrid.count)
//        // 初始化第一列，只要碰到一个 1 ，那么后边都无法走到
//        for i in 0..<obstacleGrid.count {
//            if obstacleGrid[i][0] == 1 {
//                break
//            }
//            steps[i][0] = 1
//        }
//        // 初始化第一行，只要碰到一个 1 ，那么后边都无法走到
//        for j in 0..<obstacleGrid[0].count {
//            if obstacleGrid[0][j] == 1 {
//                break
//            }
//            steps[0][j] = 1
//        }
//        // 在没有障碍物的情况下，到达某一个点只能从左边或者上边
//        for i in 1..<obstacleGrid.count {
//            for j in 1..<obstacleGrid[0].count {
//                steps[i][j] = obstacleGrid[i][j] == 1 ? 0 : steps[i - 1][j] + steps[i][j - 1]
//            }
//        }
//        return steps[obstacleGrid.count - 1][obstacleGrid[0].count - 1]
        let n = obstacleGrid.count, m = obstacleGrid[0].count
        var f = [Int](repeating: 0, count: m)
        f[0] = obstacleGrid[0][0] == 0 ? 1 : 0
        for i in 0..<n {
            for j in 0..<m {
                if obstacleGrid[i][j] == 1 {
                    f[j] = 0
                    continue
                }
                if j - 1 >= 0 && obstacleGrid[i][j - 1] == 0 {
                    f[j] += f[j - 1]
                }
            }
        }
        return f[m - 1]
    }
    
    // 64. 最小路径和
    func minPathSum(_ grid: [[Int]]) -> Int {
        if grid.count == 0 || grid[0].count == 0 {
            return 0
        }
        let rows = grid.count, columns = grid[0].count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: columns), count: rows)
        dp[0][0] = grid[0][0]
        for i in 1..<rows {
            dp[i][0] = dp[i - 1][0] + grid[i][0]
        }
        for j in 1..<columns {
            dp[0][j] = dp[0][j - 1] + grid[0][j]
        }
        for i in 1..<rows {
            for j in 1..<columns {
                dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j]
            }
        }
        return dp[rows - 1][columns - 1]
    }
    
    // 65. 有效数字
    func isNumber(_ s: String) -> Bool {
        
        enum State {
            case Initial
            case IntSign
            case Integer
            case Point
            case PointWithoutInt
            case Fraction
            case Exp
            case ExpSign
            case ExpNumber
            case End
        }
        
        enum CharType {
            case Number
            case Exp
            case Point
            case Sign
            case Illegal
        }
        
        func toCharType(_ ch: String) -> CharType {
            if ch >= "0" && ch <= "9" {
                return .Number
            } else if ch == "e" || ch == "E" {
                return .Exp
            } else if ch == "." {
                return .Point
            } else if ch == "+" || ch == "-" {
                return .Sign
            } else {
                return .Illegal
            }
        }
        
        var transfer = [State: [CharType : State]]()
        
        let intialMap = [CharType.Number: State.Integer, .Point: .PointWithoutInt, .Sign: .IntSign]
        transfer[.Initial] = intialMap
        
        let intSignMap = [CharType.Number: State.Integer, .Point: .PointWithoutInt]
        transfer[.IntSign] = intSignMap
        
        let integerMap = [CharType.Number: State.Integer, .Exp: .Exp, .Point: .Point]
        transfer[.Integer] = integerMap
        
        let pointMap = [CharType.Number : State.Fraction, .Exp: .Exp]
        transfer[.Point] = pointMap
        
        let pointWithoutIntMap = [CharType.Number: State.Fraction]
        transfer[.PointWithoutInt] = pointWithoutIntMap
        
        let fractionMap = [CharType.Number: State.Fraction, .Exp: .Exp]
        transfer[.Fraction] = fractionMap
        
        let expMap = [CharType.Number: State.ExpNumber, .Sign: .ExpSign]
        transfer[.Exp] = expMap
        
        let expSignMap = [CharType.Number: State.ExpNumber]
        transfer[.ExpSign] = expSignMap
        
        let expNumberMap = [CharType.Number: State.ExpNumber]
        transfer[.ExpNumber] = expNumberMap
        
        let sArray = s.map { $0 }
        
        var state = State.Initial
        
        for char in sArray {
            let type = toCharType(String(char))
            if transfer[state]?[type] == nil {
                return false
            } else {
                state = transfer[state]![type]!
            }
        }
        return state == .Integer || state == .Point || state == .Fraction || state == .ExpNumber || state == .End
    }
    
    // 66. 加一
    func plusOne(_ digits: [Int]) -> [Int] {
        var value = digits
        let count = value.count
        for i in 0..<count {
            let index = count - 1 - i
            value[index] += 1
            value[index] %= 10
            if value[index] != 0 {
                return value
            }
        }
        value.insert(1, at: 0)
        return value
    }
    
    // 67. 二进制求和
    func addBinary(_ a: String, _ b: String) -> String {
        var ans = ""
        
        let length = max(a.count, b.count)
        let aArray = a.map { String($0) }
        let bArray = b.map { String($0) }
        var carry = 0
        
        for i in 0..<length {
            carry += i < aArray.count ? Int(aArray[aArray.count - 1 - i])! : 0
            carry += i < bArray.count ? Int(bArray[bArray.count - 1 - i])! : 0
            ans.append(String(carry % 2))
            carry /= 2
        }
        
        if carry > 0 {
            ans.append("1")
        }
        // 翻转字符串
        let str = ans.reversed()
        return String(str)
    }
    
    // 68. 文本左右对齐
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var index = [Int](repeating: 0, count: 0)
        var ans = [String](repeating: "", count: 0)
        var str = ""
        
        func subString(_ str: inout String, _ words: [String], _ i: Int) {
            if str.count + words[i].count < maxWidth {
                // 如果当前单词加入到当前的行中时，没有超过要求，直接放进来好了
                str.append(words[i]) // 拼接当前行内容
                index.append(str.count) // 然后记下来当前空格位置
                str.append(" ")
            } else if str.count + words[i].count == maxWidth {
                // 如果正好碰到了边界，那么就加进来当前单词后，放到最终的返回值中
                str.append(words[i])
                ans.append(str)
                // 然后清空当前的缓冲内容
                str.removeAll()
                index.removeAll()
            } else {
                // 如果添加了当前单词后，超出了容量限制，就进行空格调整
                // 首先记录剩余多少空格
                var space = maxWidth - str.count
                // 然后把最后一个空格去掉，把所有的空格放到中间去
                if index.count > 1 {
                    str.removeLast()
                    index.removeLast()
                    space += 1
                }
                // 计算每一个单词中间的空格基本个数（every），以及额外的空格（remain）
                var every = 0, remain = 0
                if !index.isEmpty {
                    every = space / index.count
                    remain = space % index.count
                }
                // 从后往前进行空格插入，这样方便计算下标在哪里
                for j in 0...index.count - 1 {
                    let jIndex = index.count - 1 - j
                    let cs = [String](repeating: " ", count: every + (jIndex < remain ? 1 : 0))
                    let mutableString = NSMutableString.init(string: str)
                    mutableString.insert(cs.joined(), at: index[jIndex])
                    str = mutableString as String
                }
                // 然后放到返回值中
                ans.append(str)
                str.removeAll()
                index.removeAll()
                subString(&str, words, i)
            }
        }
        
        // 把单词挨个放到结果中去
        for i in 0..<words.count {
            subString(&str, words, i)
        }
        
        // 对剩余的单词进行空格拼接
        if str.count > 0 {
            if str.count < maxWidth {
                let cs = [String](repeating: " ", count: maxWidth - str.count)
                str += cs.joined()
            }
            ans.append(str)
        }
        return ans
    }
    
    // 69. x 的平方根
    func mySqrt(_ x: Int) -> Int {
        var l = 0, r = x / 2 + 1, ans = -1
        while l <= r {
            let mid = (l + r) / 2
            if mid * mid <= x {
                ans = mid
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return ans
    }
}
