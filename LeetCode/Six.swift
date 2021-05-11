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
}
