//
//  ThirtyOne.swift
//  LeetCode
//
//  Created by UED on 2021/8/24.
//

import Foundation

class ThirtyOne {
    // 310. 最小高度树
    func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
        var arr: [Set<Int>]
        switch n {
        case 0:
            return []
        case 1:
            return [0]
        case 2:
            return [0, 1]
        default:
            arr = [Set<Int>](repeating: Set<Int>(), count: n)
        }
        var duCount = [Int](repeating: 0, count: n)
        
        // 构造邻接链表
        for i in 0..<edges.count {
            let i0 = edges[i][0], i1 = edges[i][1]
            duCount[i0] += 1
            duCount[i1] += 1
            arr[i0].insert(i1)
            arr[i1].insert(i0)
        }
        
        // 记录节点 度 = 1 的节点
        var delArr = [Int]()
        var nextDelArr = delArr
        
        for i in 0..<duCount.count {
            if duCount[i] == 1 {
                delArr.append(i)
            }
        }
        
        while true {
            nextDelArr.removeAll()
            for i in delArr {
                guard let d = arr[i].popFirst() else {
                    continue
                }
                arr[d].remove(i)
                if arr[d].count == 1 {
                    nextDelArr.append(d)
                }
            }
            if nextDelArr.count == 0 {
                return delArr
            } else if nextDelArr.count == 1 {
                return nextDelArr
            } else {
                delArr = nextDelArr
            }
        }
        
        return [0]
    }
    
    // 312. 戳气球
    func maxCoins(_ nums: [Int]) -> Int {
        let n = nums.count
        var rec = [[Int]](repeating: [Int](repeating: -1, count: n + 2), count: n + 2)
        var val = [Int](repeating: 1, count: n + 2)
        for i in 1...n {
            val[i] = nums[i - 1]
        }
        
        func solve(_ left: Int, _ right: Int) -> Int {
            if left >= right - 1 {
                return 0
            }
            if rec[left][right] != -1 {
                return rec[left][right]
            }
            for i in left + 1..<right {
                var sum = val[left] * val[i] * val[right]
                sum += solve(left, i) + solve(i, right)
                rec[left][right] = max(rec[left][right], sum);
            }
            return rec[left][right];
        }
        
        return solve(0, n + 1)
    }
}
