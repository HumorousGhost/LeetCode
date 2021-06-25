//
//  Sixteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/24.
//

import Cocoa

class Sixteen {
    // 160. 相交链表
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil {
            return nil
        }
        
        func address(_ obj: Any?) -> Int {
            let point = Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque()
            return point.hashValue
        }
        
        var pA = headA, pB = headB
        while address(pA) != address(pB) {
            pA = pA == nil ? headB : pA?.next
            pB = pB == nil ? headA : pB?.next
        }
        return pA
    }
    
    // 162. 寻找峰值
    func findPeakElement(_ nums: [Int]) -> Int {
        var nums = nums
        nums.insert(Int.min, at: 0)
        nums.append(Int.min)
        for i in 1..<nums.count - 1 {
            if nums[i] > nums[i - 1] && nums[i] > nums[i + 1] {
                return i - 1
            }
        }
        return Int.min
    }
    
    // 164. 最大间距
    func maximumGap(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return 0
        }
        
        let minValue = nums.min()!
        let maxValue = nums.max()!
        
        let d = max(1, (maxValue - minValue) / (nums.count - 1))
        let bucketSize = ((maxValue - minValue) / d) + 1
        // 存储（桶内最小值，桶内最大值）对，（-1， -1）表示该桶是空的
        var bucket = [[Int]](repeating: [-1, -1], count: bucketSize)
        
        for i in 0..<nums.count {
            let idx = (nums[i] - minValue) / d
            if bucket[idx][0] == -1 {
                bucket[idx][0] = nums[i]
                bucket[idx][1] = nums[i]
            } else {
                bucket[idx][0] = min(bucket[idx][0], nums[i])
                bucket[idx][1] = max(bucket[idx][1], nums[i])
            }
        }
        
        var res = 0
        var prev = -1
        for i in 0..<bucketSize {
            if bucket[i][0] == -1 {
                continue
            }
            if prev != -1 {
                res = max(res, bucket[i][0] - bucket[prev][1])
            }
            prev = i
        }
        
        return res
    }
}
