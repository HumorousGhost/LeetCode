//
//  Nine.swift
//  LeetCode
//
//  Created by UED on 2021/5/21.
//

import Cocoa

class Nine: NSObject {
    // 90. 子集 II
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var t = [Int](repeating: 0, count: 0)
        var ans = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        
        func dfs(_ choosePre: Bool, _ cur: Int, _ nums: [Int]) {
            if cur == nums.count {
                ans.append(t)
                return
            }
            dfs(false, cur + 1, nums)
            if !choosePre && cur > 0 && nums[cur - 1] == nums[cur] {
                return
            }
            t.append(nums[cur])
            dfs(true, cur + 1, nums)
            t.removeLast()
        }
        
        let sortNums = nums.sorted()
        dfs(false, 0, sortNums)
        return ans
    }
    
    // 91. 解码方法
    func numDecodings(_ s: String) -> Int {
        let n = s.count
        let sArr = s.map { String($0) }
        var f = [Int](repeating: 0, count: n + 1)
        f[0] = 1
        for i in 1...n {
            if sArr[i - 1] != "0" {
                f[i] += f[i - 1]
            }
            
            if i > 1 && sArr[i - 2] != "0" && (sArr[i - 2] as NSString).integerValue * 10 + (sArr[i - 1] as NSString).integerValue <= 26 {
                f[i] += f[i - 2]
            }
        }
        return f[n]
    }
    
    // 92. 反转链表 II
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        // 设置 dummyNode
        let dummyNode = ListNode.init(-1, head)
        // 找到 left 前一个节点
        var pre: ListNode? = dummyNode
        for _ in 0..<left - 1 {
            pre = pre?.next
        }
        // 待翻转节点
        let cur = pre?.next
        var next: ListNode?
        for _ in 0..<right - left {
            next = cur?.next
            cur?.next = next?.next
            next?.next = pre?.next
            pre?.next = next
        }
        
        return dummyNode.next
    }
}
