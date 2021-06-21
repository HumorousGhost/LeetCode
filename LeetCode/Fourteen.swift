//
//  Fourteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/16.
//

import Cocoa

class Fourteen: NSObject {
    // 140. 单词拆分 II
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        var map = [Int: [[String]]]()
        let sArr = s.map { String($0) }
        
        func backtrack(_ length: Int, _ index: Int) -> [[String]] {
            if !map.keys.contains(index) {
                var wordBreaks = [[String]]()
                if index == length {
                    wordBreaks.append([String]())
                } else {
                    for i in index + 1...length {
                        let word = sArr[index..<i].joined()
                        if wordDict.contains(word) {
                            let nextWordBreaks = backtrack(length, i)
                            for nextWordBreak in nextWordBreaks {
                                var wordBreak = nextWordBreak
                                wordBreak.insert(word, at: 0)
                                wordBreaks.append(wordBreak)
                            }
                        }
                    }
                }
                map[index] = wordBreaks
            }
            return map[index]!
        }
        
        let wordBreaks = backtrack(s.count, 0)
        var breakList = [String]()
        for wordBreak in wordBreaks {
            breakList.append(wordBreak.joined(separator: " "))
        }
        return breakList
    }
    
    // 141. 环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        /** // 方法一
        var array = [String]()
        var head = head
        while head != nil {
            if array.contains(head.debugDescription) {
                return true
            } else {
                array.append(head.debugDescription)
            }
            head = head?.next
        }
        
        return false
        */
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var fast = head?.next
        while slow.debugDescription != fast.debugDescription {
            if fast == nil || fast?.next == nil {
                return false
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return true
    }
    
    // 142. 环形链表 II
    func detectCycle(_ head: ListNode?) -> ListNode? {
        /** // 方法一
        var array = [String]()
        var pos = head
        while pos != nil {
            if array.contains(pos.debugDescription) {
                return pos
            } else {
                array.append(pos.debugDescription)
            }
            pos = pos?.next
        }
        return nil
        */
        if head == nil {
            return nil
        }
        var slow = head, fast = head
        while fast != nil {
            slow = slow?.next
            if fast?.next != nil {
                fast = fast?.next?.next
            } else {
                return nil
            }
            if fast.debugDescription == slow.debugDescription {
                var ptr = head
                while ptr.debugDescription != slow.debugDescription {
                    ptr = ptr?.next
                    slow = slow?.next
                }
                return ptr
            }
        }
        return nil
    }
    
    // 143. 重排链表
    func reorderList(_ head: ListNode?) {
        var nodes = [ListNode?]()
        var node = head
        while node != nil {
            nodes.append(node)
            node = node?.next
        }
        
        var i = 0, j = nodes.count - 1
        while i < j {
            let leftNode = nodes[i]
            let rightNode = nodes[j]
            leftNode?.next = rightNode
            i += 1
            if i == j {
                break
            }
            rightNode?.next = nodes[i]
            j -= 1
        }
        let leftNode = nodes[i]
        leftNode?.next = nil
    }
    
    // 144. 二叉树的前序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var orders = [Int]()
        
        func preorder(_ root: TreeNode?) {
            if root == nil {
                return
            }
            orders.append(root!.val)
            preorder(root?.left)
            preorder(root?.right)
        }
        
        preorder(root)
        
        return orders
    }
    
    // 145. 二叉树的后序遍历
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var orders = [Int]()
        
        func postorder(_ root: TreeNode?) {
            if root == nil {
                return
            }
            postorder(root?.left)
            postorder(root?.right)
            orders.append(root!.val)
        }
        
        postorder(root)
        
        return orders
    }
    
    // 147. 对链表进行插入排序
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return head
        }
        let dummyHead = ListNode.init(0, head)
        var lastSorted = head, curr = head?.next
        while curr != nil {
            if lastSorted!.val <= curr!.val {
                lastSorted = lastSorted?.next
            } else {
                var prev: ListNode? = dummyHead
                while prev?.next != nil && prev!.next!.val <= curr!.val {
                    prev = prev?.next
                }
                lastSorted?.next = curr?.next
                curr?.next = prev?.next
                prev?.next = curr
            }
            curr = lastSorted?.next
        }
        return dummyHead.next
    }
}
