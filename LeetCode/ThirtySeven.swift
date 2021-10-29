//
//  ThirtySeven.swift
//  LeetCode
//
//  Created by UED on 2021/10/27.
//

import Foundation

class ThirtySeven {
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
}
