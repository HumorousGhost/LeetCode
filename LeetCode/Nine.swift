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
    
    // 93. 复原 IP 地址
    func restoreIpAddresses(_ s: String) -> [String] {
        let COUNT = 4
        var ans = [String](repeating: "", count: 0)
        var segments = [Int](repeating: 0, count: COUNT)
        let sArr = s.map { String($0) }
        
        func dfs(_ segId: Int, _ segStart: Int) {
            // 如果找到了 4 段 IP 地址并且遍历完了字符串，那么就是一种答案
            if segId == COUNT {
                if segStart == sArr.count {
                    var ipAddr = ""
                    for i in 0..<COUNT {
                        ipAddr.append(String(segments[i]))
                        if i != COUNT - 1 {
                            ipAddr.append(".")
                        }
                    }
                    ans.append(ipAddr)
                }
                return
            }
            
            // 如果还没有找到 4 段 IP 地址就已经遍历完了字符串，那么提前回溯
            if segStart == sArr.count {
                return
            }
            
            // 由于不能前导零，如果当前数字为 0，那么这一段 IP 地址只能为 0
            if sArr[segStart] == "0" {
                segments[segId] = 0
                dfs(segId + 1, segStart + 1)
            }
            
            // 一般情况，枚举每一种可能性并递归
            var addr = 0
            for segEnd in segStart..<sArr.count {
                addr = addr * 10 + (sArr[segEnd] as NSString).integerValue
                if addr > 0 && addr <= 0xFF {
                    segments[segId] = addr
                    dfs(segId + 1, segEnd + 1)
                } else {
                    break
                }
            }
        }
        
        dfs(0, 0)
        
        return ans
    }
}
