//
//  ThirtyTwo.swift
//  LeetCode
//
//  Created by UED on 2021/9/1.
//

import Foundation

class ThirtyTwo {
    // 321. 拼接最大数
    func maxNumber(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [Int] {
        func compare(_ subsequence1: [Int], _ index1: Int, _ subsequence2: [Int], _ index2: Int) -> Int {
            var index1 = index1, index2 = index2
            let x = subsequence1.count, y = subsequence2.count
            while index1 < x && index2 < y {
                let difference = subsequence1[index1] - subsequence2[index2]
                if difference != 0 {
                    return difference
                }
                index1 += 1
                index2 += 1
            }
            return (x - index1) - (y - index2)
        }
        
        func merge(_ subsequence1: [Int], _ subsequence2: [Int]) -> [Int] {
            let x = subsequence1.count, y = subsequence2.count
            if x == 0 {
                return subsequence2
            }
            if y == 0 {
                return subsequence1
            }
            
            let mergeCount = x + y
            var merged = [Int](repeating: 0, count: mergeCount)
            var index1 = 0, index2 = 0
            for i in 0..<mergeCount {
                if compare(subsequence1, index1, subsequence2, index2) > 0 {
                    merged[i] = subsequence1[index1]
                    index1 += 1
                } else {
                    merged[i] = subsequence2[index2]
                    index2 += 1
                }
            }
            return merged
        }
        
        func maxSubsequence(_ nums: [Int], _ k: Int) -> [Int] {
            var stack = [Int](repeating: 0, count: k)
            var top = -1, remain = nums.count - k
            for num in nums {
                while top >= 0 && stack[top] < num && remain > 0 {
                    top -= 1
                    remain -= 1
                }
                if top < k - 1 {
                    top += 1
                    stack[top] = num
                } else {
                    remain -= 1
                }
            }
            return stack
        }
        
        let m = nums1.count, n = nums2.count
        var subsequence = [Int](repeating: 0, count: k)
        let start = max(0, k - n), end = min(k, m)
        for i in start...end {
            let subsequence1 = maxSubsequence(nums1, i)
            let subsequence2 = maxSubsequence(nums2, k - i)
            let curMaxSubsequence = merge(subsequence1, subsequence2)
            if compare(curMaxSubsequence, 0, subsequence, 0) > 0 {
                subsequence = curMaxSubsequence
            }
        }
        
        return subsequence
    }
    
    // 322. 零钱兑换
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard amount != 0 else {
            return 0
        }
        let max = amount + 1
        var dp = [Int](repeating: max, count: amount + 1)
        dp[0] = 0
        for i in 1...amount {
            for j in 0..<coins.count {
                if coins[j] <= i {
                    dp[i] = min(dp[i], dp[i - coins[j]] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]
    }
    
    // 324. 摆动排序 II
    func wiggleSort(_ nums: inout [Int]) {
        let sortNums = nums.sorted()
        var tail =  nums.count - 1
        var mid = tail / 2
        for i in 0..<nums.count {
            if i % 2 == 0 {
                nums[i] = sortNums[mid]
                mid -= 1
            } else {
                nums[i] = sortNums[tail]
                tail -= 1
            }
        }
    }
    
    // 326. 3 的幂
    func isPowerOfThree(_ n: Int) -> Bool {
        guard n > 0 else {
            return false
        }
        var n = n
        while n % 3 == 0 {
            n /= 3
        }
        return n == 1
    }
    
    // 327. 区间和的个数
    func countRangeSum(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {

        var sum = [Int](repeating: 0, count: nums.count + 1)
        for i in 0..<nums.count {
            sum[i + 1] = nums[i] + sum[i]
        }
        
        func countRangeSumRecurive(_ left: Int, _ right: Int) -> Int {
            guard left != right else {
                return 0
            }
            
            let mid = (left + right) / 2
            let n1 = countRangeSumRecurive(left, mid)
            let n2 = countRangeSumRecurive(mid + 1, right)
            var ret = n1 + n2
            
            // 首先统计下标对的数量
            var i = left, l = mid + 1, r = mid + 1
            while i <= mid {
                while l <= right && sum[l] - sum[i] < lower {
                    l += 1
                }
                while r <= right && sum[r] - sum[i] <= upper {
                    r += 1
                }
                ret += r - l
                i += 1
            }
            
            // 随后合并两个排序数组
            var sorted = [Int](repeating: 0, count: right - left + 1)
            var p1 = left, p2 = mid + 1, p = 0
            while p1 <= mid || p2 <= right {
                if p1 > mid {
                    sorted[p] = sum[p2]
                    p += 1
                    p2 += 1
                } else if p2 > right {
                    sorted[p] = sum[p1]
                    p += 1
                    p1 += 1
                } else {
                    if sum[p1] < sum[p2] {
                        sorted[p] = sum[p1]
                        p += 1
                        p1 += 1
                    } else {
                        sorted[p] = sum[p2]
                        p += 1
                        p2 += 1
                    }
                }
            }
            for j in 0..<sorted.count {
                sum[left + j] = sorted[j]
            }
            return ret
        }
        
        return countRangeSumRecurive(0, sum.count - 1)
    }
    
    // 328. 奇偶链表
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard head != nil else {
            return head
        }
        
        let evenHead = head?.next
        var odd = head, even = evenHead
        while even != nil && even?.next != nil {
            odd?.next = even?.next
            odd = odd?.next
            even?.next = odd?.next
            even = even?.next
        }
        odd?.next = evenHead
        return head
    }
}
