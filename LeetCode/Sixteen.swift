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
                return i
            }
        }
        return Int.min
    }
}
