//
//  ThirtySeven.swift
//  LeetCode
//
//  Created by UED on 2021/10/27.
//

import Foundation

class ThirtySeven: GuessGame {
    
    
    // 371. 两整数之和
    func getSum(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while b != 0 {
            let temp = (a & b) << 1
            a = a ^ b
            b = temp
        }
        return a
    }
    
    // 372. 超级次方
    func superPow(_ a: Int, _ b: [Int]) -> Int {
        
        let mod = 1337
        
        func modPow(_ base: Int, _ exponent: Int) -> Int {
            var ans = 1, base = base, exponent = exponent
            
            while exponent > 0 {
                if exponent & 1 == 1 {
                    ans = (base * ans) % mod
                }
                base = (base * base) % mod
                exponent >>= 1
            }
            return ans
        }
        
        var base = a % mod, ans = 1, x = base
        
        b.reversed().forEach { bit in
            ans = (ans * modPow(x, bit)) % mod
            x = modPow(x, 10) % mod
        }
        return ans
    }
    
    // 373. 查找和最小的K对数字
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        var res = [[Int]]()
        let n = nums1.count, m = nums2.count
        guard n > 0 && m > 0 else {
            return []
        }
        // 利用一个数组来保存 nums1 中每个元素对应的最小组合的 nums2 下标，初始值为 0
        var f = [Int](repeating: 0, count: n)
        
        // 外层最多遍历 k 次，获取前 k 个最小值
        while res.count < k {
            var cur = 0
            // 遍历每个 nums1 元素对应 nums2 最小可用组合，并获取最小组合
            for i in 1..<n {
                // 当前 i 位置可用组合已经用完了
                if f[i] == m {
                    continue
                }
                // 比较获取最小的组合
                if f[cur] == m || nums1[cur] + nums2[f[cur]] > nums1[i] + nums2[f[i]] {
                    cur = i
                }
            }
            // 所有的组合都用完了，就跳出循环
            if f[cur] == m {
                break
            }
            // 答案中添加当前组合
            res.append([nums1[cur], nums2[f[cur]]])
            // 当前组合中 nums1 元素对应的 nums2 元素下标加一，这样就不会重复用到之前的组合
            f[cur] += 1
        }
        
        return res
    }
    
    // 374. 猜数字大小
    func guess(_ nums: Int) -> Int {
        return 0
    }
    /**
     * Forward declaration of guess API.
     * @param  num -> your guess number
     * @return          -1 if the picked number is lower than your guess number
     *                  1 if the picked number is higher than your guess number
     *               otherwise return 0
     * func guess(_ num: Int) -> Int
     */
    func guessNumber(_ n: Int) -> Int {
        var left = 1, right = n
        while left < right {
            let mid = (left + right) / 2
            let guessNum = guess(mid)
            if guessNum == 0 {
                return mid
            } else if guessNum == 1 {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left
    }
    
    // 375. 猜数字大小 II
    func getMoneyAmout(_ n: Int) -> Int {
        
        var sign = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
        
        func calculate(_ left: Int, _ right: Int) -> Int {
            guard left < right else {
                return 0
            }
            
            if sign[left][right] != 0 {
                return sign[left][right]
            }
            
            var minres = Int.max
            let mid = (left + right) / 2
            for i in mid...right {
                let res = i + max(calculate(i + 1, right), calculate(left, i - 1))
                minres = min(res, minres)
            }
            sign[left][right] = minres
            return minres
        }
        
        return calculate(1, n)
    }
    
    // 376. 摆动序列
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else {
            return n
        }
        
        var up = [Int](repeating: 0, count: n)
        var down = [Int](repeating: 0, count: n)
        up[0] = 1
        down[0] = 1
        for i in 1..<n {
            if nums[i] > nums[i - 1] {
                up[i] = max(up[i - 1], down[i - 1] + 1)
                down[i] = down[i - 1]
            } else if nums[i] < nums[i - 1] {
                up[i] = up[i - 1]
                down[i] = max(up[i - 1] + 1, down[i - 1])
            } else {
                up[i] = up[i - 1]
                down[i] = down[i - 1]
            }
        }
        
        return max(up[n - 1], down[n - 1])
    }
}
