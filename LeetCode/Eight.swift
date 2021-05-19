//
//  Eight.swift
//  LeetCode
//
//  Created by UED on 2021/5/18.
//

import Cocoa

class Eight: NSObject {
    // 80. 删除有序数组中的重复项 II
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var map = [Int: Int]()
        var i = nums.count - 1
        while i >= 0 {
            let value = nums[i]
            map[value] = map[value] != nil ? map[value]! + 1 : 1
            if map[value]! > 2 {
                nums.remove(at: i)
            }
            i -= 1
        }
        return nums.count
    }
    
    // 81. 搜索旋转排序数组 II
    func search(_ nums: [Int], _ target: Int) -> Bool {
        
        let n = nums.count
        if n == 0 {
            return false
        }
        
        if n == 1 {
            return nums[0] == target
        }
        
        var l = 0, r = n - 1
        while l <= r {
            let mid = (l + r) / 2
            if nums[mid] == target {
                return true
            }
            if nums[l] == nums[mid] && nums[mid] == nums[r] {
                l += 1
                r -= 1
            } else if nums[l] <= nums[mid] {
                if nums[l] <= target && target < nums[mid] {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if nums[mid] < target && target <= nums[r] {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return false
    }
    
    // 82. 删除排序链表中的重复元素II
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return head
        }
        let dummy = ListNode.init(0, head)
        
        var cur: ListNode? = dummy
        
        while cur?.next != nil && cur?.next?.next != nil {
            if cur?.next?.val == cur?.next?.next?.val {
                let x = cur?.next?.val
                while cur?.next != nil && cur?.next?.val == x {
                    cur?.next = cur?.next?.next
                }
            } else {
                cur = cur?.next
            }
        }
        
        return dummy.next
    }
}
