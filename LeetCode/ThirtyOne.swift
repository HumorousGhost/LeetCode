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
    
    // 313. 超级丑数
    func nthSuperUglyNumber(_ n: Int, _ primes: [Int]) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        dp[1] = 1
        let m = primes.count
        var pointers = [Int](repeating: 1, count: m)
        guard n > 2 else {
            return n
        }
        for i in 2...n {
            var nums = [Int](repeating: 0, count: m)
            var minNum = Int.max
            for j in 0..<m {
                nums[j] = dp[pointers[j]] * primes[j]
                minNum = min(minNum, nums[j])
            }
            dp[i] = minNum
            for j in 0..<m {
                if minNum == nums[j] {
                    pointers[j] += 1
                }
            }
        }
        return dp[n]
    }
    
    // 315. 计算右侧小于当前元素的个数
    func countSmaller(_ nums: [Int]) -> [Int] {
        
        guard nums.count > 0 else { return [] }
        
        var resultArray = Array(repeating: 0, count: nums.count)
        var originalArray = Array(repeating: (0, 0), count: nums.count)
        for i in 0 ..< nums.count {
            originalArray[i] = (i, nums[i])
        }

        func sortSplit(_ nums: inout [(Int, Int)], _ start: Int, _ end: Int, _ temp: inout [(Int, Int)]) {
                guard start < end else { return }
                let middle = start + (end - start) / 2
                sortSplit(&nums, start, middle, &temp)
                sortSplit(&nums, middle + 1, end, &temp)
                mergeArray(&nums, start, middle, end, &temp)
            }
        
        func mergeArray(_ nums: inout [(Int, Int)], _ start: Int, _ middle: Int, _ end: Int, _ tempArr: inout [(Int, Int)]) {
            var leftIndex = start
            var rightIndex = middle + 1
            var tempIndex = 0
                
            while leftIndex <= middle && rightIndex <= end {
                if nums[leftIndex].1 <= nums[rightIndex].1 {
                    resultArray[nums[leftIndex].0] += rightIndex - middle - 1
                    tempArr[tempIndex] = nums[leftIndex]
                    leftIndex += 1
                    tempIndex += 1
                } else {
                    tempArr[tempIndex] = nums[rightIndex]
                    rightIndex += 1
                    tempIndex += 1
                }
            }
            while leftIndex <= middle {
                resultArray[nums[leftIndex].0] += rightIndex - middle - 1
                tempArr[tempIndex] = nums[leftIndex]
                leftIndex += 1
                tempIndex += 1
            }
            while rightIndex <= end {
                tempArr[tempIndex] = nums[rightIndex]
                rightIndex += 1
                tempIndex += 1
            }
            for i in 0 ... end - start {
                nums[start + i] = tempArr[i]
            }
        }
        
        var tempArray = Array(repeating: (0, 0), count: nums.count)
        sortSplit(&originalArray, 0, nums.count - 1, &tempArray)
        return resultArray
    }
}
