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
}
