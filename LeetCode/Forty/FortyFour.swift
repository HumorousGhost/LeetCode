//
//  FortyFour.swift
//  LeetCode
//
//  Created by UED on 2022/2/23.
//

import Foundation

class FortyFour {
    // 440. 字典序的第K小数字
    func findKthNumber(_ n: Int, _ k: Int) -> Int {
        
        func stepCount(_ n: Int, _ node: Int) -> Int {
            var cur = node, next = node + 1, sum = 0
            while cur <= n {
                sum += min(n - cur + 1, next - cur)
                cur *= 10
                next *= 10
            }
            return sum
        }
        
        var cur = 1, needStep = k - 1
        
        while needStep > 0 {
            let tempStep = stepCount(n, cur)
            if tempStep > needStep {
                cur *= 10
                needStep -= 1
            } else {
                cur += 1
                needStep -= tempStep
            }
        }
        
        return cur
    }
    
    // 441. 排列硬币
    func arrangeCoins(_ n: Int) -> Int {
        var sum = 0
        for i in 0..<n {
            sum += i + 1
            if sum == n {
                return i + 1
            } else if sum > n {
                return i
            }
        }
        return 0
    }
    
    // 442. 数组中重复的数据
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var newNums = nums
        var res = [Int]()
        for i in 0..<newNums.count {
            let index = abs(newNums[i]) - 1
            if newNums[index] < 0 {
                res.append(index + 1)
                continue
                
            }
            newNums[index] = -newNums[index]
        }
        return res
    }
    
    // 443. 压缩字符串
    func compress(_ chars: inout [Character]) -> Int {
        guard chars.count > 1 else {
            return chars.count
        }
        
        var markIndex = 0
        var rangeCount = 0
        
        for flag in 0..<chars.count {
            rangeCount += 1
            if flag == chars.count - 1 || chars[flag] != chars[flag + 1] {
                // 计算阶段
                chars[markIndex] = chars[flag]
                markIndex += 1
                if rangeCount > 1 {
                    let rangeString = "\(rangeCount)"
                    let rangeArray = rangeString.map({$0})
                    var rangeIndex = 0
                    while rangeIndex < rangeArray.count {
                        let rangeChar = rangeArray[rangeIndex]
                        chars[markIndex] = rangeChar
                        markIndex += 1
                        rangeIndex += 1
                    }
                }
                rangeCount = 0
            }
        }
        return markIndex
    }
    
    // 445. 两数相加 II
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        var stack1 = [Int](), stack2 = [Int]()
        while l1 != nil {
            stack1.append(l1!.val)
            l1 = l1?.next
        }
        while l2 != nil {
            stack2.append(l2!.val)
            l2 = l2?.next
        }
        var carry = 0
        var ans: ListNode? = nil
        while !stack1.isEmpty || !stack2.isEmpty || carry != 0 {
            let a = stack1.isEmpty ? 0 : stack1.removeLast()
            let b = stack2.isEmpty ? 0 : stack2.removeLast()
            var cur = a + b + carry
            carry = cur / 10
            cur %= 10
            let curnode = ListNode.init(cur, ans)
            ans = curnode
        }
        return ans
    }
    
    // 446. 等差数列划分 II - 子序列
    func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
        
        var ans = 0
        let n = nums.count
        var f = [[Int: Int]](repeating: [Int: Int](), count: n)
        for i in 0..<n {
            for j in 0..<i {
                let d = nums[i] - nums[j]
                let cnt = f[j][d, default: 0]
                ans += cnt
                f[i][d, default: 0] += cnt + 1
            }
        }
        
        return ans
    }
    
    // 447. 回旋镖的数量
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        
        var ans = 0
        for p in points {
            var cnt = [Int: Int]()
            for q in points {
                let dis = (p[0] - q[0]) * (p[0] - q[0]) + (p[1] - q[1]) * (p[1] - q[1])
                cnt[dis, default: 0] += 1
            }
            for (_, value) in cnt {
                ans += value * (value - 1)
            }
        }
        
        return ans
    }
}
