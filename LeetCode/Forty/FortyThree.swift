//
//  FortyThree.swift
//  LeetCode
//
//  Created by UED on 2022/1/18.
//

import Foundation

class FortyThree {
    // 430. 扁平化多级双向链表
    func flatten(_ head: Node?) -> Node? {
        guard head != nil else {
            return head
        }
        
        func dfs(_ node: Node?) -> Node? {
            var cur = node
            // 记录链表的最后一个节点
            var last: Node? = nil
            
            while cur != nil {
                var next = cur?.next
                // 如果有子节点，那么首先处理子节点
                if cur?.child != nil {
                    let childLast = dfs(cur?.child)
                    
                    next = cur?.next
                    // 将 node 与 child 相连
                    cur?.next = cur?.child
                    cur?.child?.prev = cur
                    
                    // 如果 next 不为空，就将 last 与 next 相连
                    if next != nil {
                        childLast?.next = next
                        next?.prev = childLast
                    }
                    
                    // 将 child 置空
                    cur?.child = nil
                    last = childLast
                } else {
                    last = cur
                }
                cur = next
            }
            return last
        }
        _ = dfs(head)
        return head
    }
    
    // 433. 最小基因变化
    func minMutation(_ start: String, _ end: String, _ bank: [String]) -> Int {
        guard bank.contains(end) else {
            return -1
        }
        
        var bankSet = Set(bank)
        var minStep = Int.max
        
        func backtrack(_ step: Int, _ current: String) {
            if step >= minStep {
                return
            }
            if current == end {
                minStep = step
            }
            for gene in bankSet {
                var diffCount = 0
                for index in 0..<gene.count {
                    if [Character](gene)[index] != [Character](current)[index] {
                        diffCount += 1
                    }
                    if diffCount > 1 {
                        break
                    }
                }
                if diffCount == 1 {
                    bankSet.remove(gene)
                    backtrack(step + 1, gene)
                    bankSet.insert(gene)
                }
            }
        }
        backtrack(0, start)
        return minStep == Int.max ? -1 : minStep
    }
}
