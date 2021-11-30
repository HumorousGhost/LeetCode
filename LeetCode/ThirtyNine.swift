//
//  ThirtyNine.swift
//  LeetCode
//
//  Created by UED on 2021/11/15.
//

import Foundation
import AppKit

class ThirtyNine {
    // 390. 消除游戏
    func lastRemaining(_ n: Int) -> Int {
        
        func dfs(_ start: Int, _ step: Int, _ n: Int) -> Int {
            if n == 1 {
                return start
            }
            return dfs(start + (n - 1 - (n & 1)) * step, step * -2, n / 2)
        }
        
        return dfs(1, 1, n)
    }
    
    // 391. 完美矩形
    func isRectangleCover(_ rectangles: [[Int]]) -> Bool {
        
        // 计算每个小矩形面积是否等于大矩形面积
        // 看每个顶点出现的次数，如果最后出现一次的顶点不是四个，则说明不符合完美矩形
        var area = 0
        var set = Set<Int>()
        
        func key(_ x: Int, _ y: Int) -> Int {
            // 二维坐标转一维，方便比较
            // 10000007 是随便取的一个大质数
            // 这里既是溢出了也没什么问题
            return x * 100000007 + y
        }
        
        func record(_ x: Int, _ y: Int) {
            // 记录顶点出现的次数，如果一个顶点出现偶数次，则移除
            let key = key(x, y)
            if set.contains(key) {
                set.remove(key)
            } else {
                set.insert(key)
            }
        }
        
        // 记录大矩形的左下角和右上角
        var a1 = Int.max, b1 = Int.max
        var a2 = Int.min, b2 = Int.min
        
        for rectangle in rectangles {
            // 小矩形的坐标
            let x1 = rectangle[0], y1 = rectangle[1]
            let x2 = rectangle[2], y2 = rectangle[3]
            
            // 计算左下角
            if x1 < a1 || y1 < b1 {
                a1 = x1
                b1 = y1
            }
            
            // 计算右上角
            if x2 > a2 || y2 > b2 {
                a2 = x2
                b2 = y2
            }
            
            // 计算面积
            area += (x2 - x1) * (y2 - y1)
            
            // 记录每个顶点出现的次数
            record(x1, y1)
            record(x1, y2)
            record(x2, y1)
            record(x2, y2)
        }
        
        // 通过左下角和右上角坐标可以算出总面积
        let totalArea = (a2 - a1) * (b2 - b1)
        
        // 如果两个面积不相等，直接返回false
        if area != totalArea {
            return false
        }
        
        // 四个为1的顶点正好是大矩形的四个顶点
        return set.count == 4 && set.contains(key(a1, b1)) && set.contains(key(a1, b2)) && set.contains(key(a2, b1)) && set.contains(key(a2, b2))
    }
    
    // 392. 判断子序列
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        guard s.count <= t.count else {
            return false
        }
        if s.count == 0 {
            return true
        }
        let sChars = s.map({$0})
        var index = 0
        for char in t {
            if index == s.count {
                break
            }
            if index < s.count && sChars[index] == char {
                index += 1
            }
        }
        return index == s.count
    }
    
    // 393. UTF-8 编码验证
    func validUtf8(_ data: [Int]) -> Bool {
        
        let type0 = 0b00000000, type1 = 0b10000000, type2 = 0b11000000, type3 = 0b11100000, type4 = 0b11110000
        let masks = [0b10000000, 0b11000000, 0b11100000, 0b11110000, 0b11111000]
        let types = [type0, type1, type2, type3, type4]
        let DFA = [0: [type0: 0, type2: 1, type3: 2, type4: 3],
                   1: [type1: 0],
                   2: [type1: 4],
                   3: [type1: 5],
                   4: [type1: 0],
                   5: [type1: 6],
                   6: [type1: 0]]
        
        func getType(_ input: Int) -> Int {
            for i in 0..<types.count {
                if (masks[i] & input) == types[i] {
                    return types[i]
                }
            }
            return -1
        }
        
        func getNext(_ cur: Int, _ input: Int) -> Int? {
            let type = getType(input)
            if type == -1 {
                return nil
            }
            return DFA[cur]?[type]
        }
        
        var cur = 0
        for datum in data {
            guard let next = getNext(cur, datum) else {
                return false
            }
            cur = next
        }
        
        return cur == 0
    }
    
    // 394. 字符串解码
    func decodeString(_ s: String) -> String {
        
        var res = ""
        var multi = 0
        var stackMulti = [Int]()
        var stackRes = [String]()
        
        for char in s {
            if char == "[" {
                stackMulti.append(multi)
                stackRes.append(res)
                multi = 0
                res = ""
            } else if char == "]" {
                var temp = ""
                let curMulti = stackMulti.removeLast()
                for _ in 0..<curMulti {
                    temp.append(res)
                }
                res = stackRes.removeLast() + temp
            } else if char.asciiValue! >= 48 && char.asciiValue! <= 57 {
                multi = multi * 10 + Int(char.asciiValue!) - 48
            } else {
                res.append(char)
            }
        }
        
        return res
    }
    
    // 395. 至少有 K 个重复字符的最长子串
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        let a: Character = "a"
        let sArr = s.map({$0})
        
        func dfs(_ left: Int, _ right: Int) -> Int {
            var cnt = [Int](repeating: 0, count: 26)
            for i in left...right {
                cnt[Int(sArr[i].asciiValue! - a.asciiValue!)] += 1
            }
            
            var split = 0
            for i in 0..<26 {
                if cnt[i] > 0 && cnt[i] < k {
                    split = i + Int(a.asciiValue!)
                    break
                }
            }
            if split == 0 {
                return right - left + 1
            }
            
            var i = left
            var ret = 0
            while i <= right {
                while i <= right && Int(sArr[i].asciiValue!) == split {
                    i += 1
                }
                if i > right {
                    break
                }
                let start = i
                while i <= right && Int(sArr[i].asciiValue!) != split {
                    i += 1
                }
                
                let length = dfs(start, i - 1)
                ret = max(ret, length)
            }
            return ret
        }
        
        return dfs(0, s.count - 1)
    }
    
    // 396. 旋转函数
    func maxRotateFunction(_ nums: [Int]) -> Int {
        let n = nums.count
        var f = [Int](repeating: 0, count: n)
        var sum = 0
        for i in 0..<n {
            sum += nums[i]
            f[0] += nums[i] * i
        }
        var ans = f[0]
        for i in 1..<n {
            f[i] = f[i - 1] + sum - n * nums[n - i]
            ans = max(f[i], ans)
        }
        return ans
    }
}
