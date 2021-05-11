//
//  Six.swift
//  LeetCode
//
//  Created by UED on 2021/5/10.
//

import Cocoa

class Six: NSObject {
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
}
