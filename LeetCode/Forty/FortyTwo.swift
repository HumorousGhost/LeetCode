//
//  FortyTwo.swift
//  LeetCode
//
//  Created by UED on 2022/1/10.
//

import Foundation

struct FortyTwo {
    // 420. 强密码检验器
    func strongPasswordChecker(_ password: String) -> Int {
        
        // 记录连续出现的字符 起始和终止坐标
        struct SameChar {
            var st: Int
            var en: Int
            var c: Character
            
            init(_ st: Int, _ en: Int, _ c: Character) {
                self.st = st
                self.en = en
                self.c = c
            }
        }
        
        func count0(_ array: [Int]) -> Int {
            var n = 0
            for arr in array {
                if arr == 0 {
                    n += 1
                }
            }
            return n
        }
        
        func find(_ array: [Int], _ n: Int) -> Int {
            var n0 = -1, n1 = -1, n2 = -1
            for i in 0..<array.count {
                if array[i] > 0 && array[i] % 3 == 0 {
                    n0 = i
                }
                if array[i] > 0 && array[i] % 3 == 1 {
                    n1 = i
                }
                if array[i] > 0 && array[i] % 3 == 2 {
                    n2 = i
                }
            }
            if n == 0 {
                return n0 > -1 ? n0 : (n2 > -1 ? n2 : n1)
            }
            if n == 1 {
                return n1 > -1 ? n1 : (n2 > -1 ? n2 : n0)
            }
            return -1
        }
        
        // 统计小写字符
        var lowerCase = 0
        // 统计大写字符
        var upwerCase = 0
        // 统计数字
        var number = 0
        // 统计连续字符出现的位置
        var sameChars = [SameChar]()
        let chars = password.map({$0})
        guard chars.count > 0 else {
            return 6
        }
        // 记录连续出现的字符
        var sameChar = SameChar(0, 0, "0")
        for i in 0..<chars.count {
            if chars[i] >= "a" && chars[i] <= "z" {
                lowerCase += 1
            } else if chars[i] >= "A" && chars[i] <= "Z" {
                upwerCase += 1
            } else if chars[i] >= "0" && chars[i] <= "9" {
                number += 1
            }
            if sameChar.c != chars[i] {
                if sameChar.en - sameChar.st >= 2 {
                    sameChars.append(sameChar)
                }
                sameChar.c = chars[i]
                sameChar.st = i
                sameChar.en = i
            } else {
                sameChar.en = i
            }
        }
        if sameChar.en - sameChar.st >= 2 {
            sameChars.append(sameChar)
        }
        // 缺失的类型，只能是 1 或 2
        var needType = count0([lowerCase, upwerCase, number])
        // 连续的字符出现的要消除的个数 连续值 - 2
        var changes = [Int]()
        for sameChar in sameChars {
            changes.append(sameChar.en - sameChar.st - 1)
        }
        var res = 0
        // 如果长度小于 6，要补的字符和缺失的类型择大
        if chars.count < 6 {
            return max(6 - chars.count, needType)
        }
        // 删除的时候，要有优先概念
        if chars.count > 20 {
            var index = find(changes, 0)
            while needType > 0 && index > -1 {
                changes[index] = max(changes[index] - 3, 0)
                res += 1
                needType -= 1
                index = find(changes, 0)
            }
            var d = chars.count - 20
            index = find(changes, 1)
            while d > 0 && index > -1 {
                d -= 1
                res += 1
                changes[index] -= 1
                index = find(changes, 1)
            }
            var n = 0
            for change in changes {
                n += change % 3 == 0 ? change / 3 : change / 3 + 1
            }
            return res + d + needType + n
        }
        var n = 0
        for change in changes {
            n += change % 3 == 0 ? change / 3 : change / 3 + 1
        }
        return max(n, needType)
    }
    
    // 421. 数组中两个数的最大异或值
    func findMaximumXOR(_ nums: [Int]) -> Int {
        
        class Trie {
            // 左子树指向表示 0 的子节点
            var left: Trie?
            // 右子树指向表示 1 的子节点
            var right: Trie?
            init() {
                left = nil
                right = nil
            }
        }
        
        // 字典树的根节点
        let root = Trie()
        // 最高位的二进制编号为 30
        let HIGH_BIT = 30
        
        func add(_ num: Int) {
            var cur: Trie? = root
            for k in (0...HIGH_BIT).reversed() {
                let bit = (num >> k) & 1
                if bit == 0 {
                    if cur?.left == nil {
                        cur?.left = Trie()
                    }
                    cur = cur?.left
                } else {
                    if cur?.right == nil {
                        cur?.right = Trie()
                    }
                    cur = cur?.right
                }
            }
        }
        
        func check(_ num: Int) -> Int {
            var cur: Trie? = root
            var x = 0
            for k in (0...HIGH_BIT).reversed() {
                let bit = (num >> k) & 1
                if bit == 0 {
                    // ai 的第 k 个二进制位为 0，应当往 表示 1 的子节点 right 走
                    if cur?.right != nil {
                        cur = cur?.right
                        x = x * 2 + 1
                    } else {
                        cur = cur?.left
                        x = x * 2
                    }
                } else {
                    // ai 的第 k 个二进制位为 1，应当往 表示 0 的子节点 left 走
                    if cur?.left != nil {
                        cur = cur?.left
                        x = x * 2 + 1
                    } else {
                        cur = cur?.right
                        x = x * 2
                    }
                }
            }
            return x
        }
        
        let n = nums.count
        var x = 0
        for i in 1..<n {
            // 将 nums[n - 1] 放入字典树，此时 nums[i .. i - 1] 都在字典树中
            add(nums[i - 1])
            // 将 nums[i] 看做 ai，找出最大的 x 更新答案
            x = max(x, check(nums[i]))
        }
        return x
    }
    
    // 423. 从英文中重建数字
    func originalDigits(_ s: String) -> String {
        var c = [Character: Int]()
        for char in s {
            c[char, default: 0] += 1
        }
        
        var cnt = [Int](repeating: 0, count: 10)
        cnt[0] = c["z"] ?? 0
        cnt[2] = c["w"] ?? 0
        cnt[4] = c["u"] ?? 0
        cnt[6] = c["x"] ?? 0
        cnt[8] = c["g"] ?? 0
        cnt[3] = (c["h"] ?? 0) - cnt[8]
        cnt[5] = (c["f"] ?? 0) - cnt[4]
        cnt[7] = (c["s"] ?? 0) - cnt[6]
        cnt[1] = (c["o"] ?? 0) - cnt[0] - cnt[2] - cnt[4]
        cnt[9] = (c["i"] ?? 0) - cnt[5] - cnt[6] - cnt[8]
        
        var ans = ""
        for i in 0..<10 {
            for _ in 0..<cnt[i] {
                ans.append("\(i)")
            }
        }
        return ans
    }
    
    // 424. 替换后的最长重复字符
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var nums = [Int](repeating: 0, count: 26)
        let sArr = s.map({$0})
        let A = Character("A").asciiValue!
        let n = sArr.count
        var maxN = Int.min
        var left = 0, right = 0
        while right < n {
            nums[Int(sArr[right].asciiValue! - A)] += 1
            maxN = max(maxN, nums[Int(sArr[right].asciiValue! - A)])
            if right - left + 1 - maxN > k {
                nums[Int(sArr[left].asciiValue! - A)] -= 1
                left += 1
            }
            right += 1
        }
        return right - left
    }
}
