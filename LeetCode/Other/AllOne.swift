//
//  AllOne.swift
//  LeetCode
//
//  Created by UED on 2022/1/20.
//

import Foundation

// 432. 全 O(1) 的数据结构
class AllOne {
    
    class ListNode { // 链表节点
        var prev: ListNode?
        var next: ListNode?
        var key: String
        var val: Int
        lazy var hashValue: Int = {
            return Unmanaged.passUnretained(self).toOpaque().hashValue
        }()
        
        init(_ key: String, _ val: Int) {
            self.key = key
            self.val = val
            self.prev = nil
            self.next = nil
        }
    }
    
    // 查找节点
    private var map = [String: ListNode]()
    // key - 节点的值，value - 链表中第一个值为key的节点
    private var first = [Int: ListNode]()
    // key - 节点的值，value - 链表中最后一个值为key的节点
    private var last = [Int: ListNode]()
    
    // 链表伪头节点
    var head = AllOne.ListNode.init("", 0)
    // 链表伪尾节点
    var tail = AllOne.ListNode.init("", 0)
    
    init() {
        head.next = tail
        tail.prev = head
    }
    
    // 将节点插入
    private func insert(_ n1: ListNode, _ n2: ListNode, _ insert: ListNode) {
        n1.next = insert
        n2.prev = insert
        insert.prev = n1
        insert.next = n2
    }
    
    // 删除节点
    private func remove(_ n: ListNode) {
        let prev = n.prev
        let next = n.next
        prev?.next = next
        next?.prev = prev
        n.prev = nil
        n.next = nil
    }
    
    // 将节点移动到prev和next之间
    private func move(_ node: ListNode, _ prev: ListNode, _ next: ListNode) {
        remove(node)
        insert(prev, next, node)
    }
    
    // 将 node 设置为新的val值起始点
    private func newFirst(_ val: Int, _ node: ListNode) {
        first[val] = node
        if last[val] == nil {
            last[val] = node
        }
    }
    
    // 将 node 设置为新的val值终止点
    private func newLast(_ val: Int, _ node: ListNode) {
        last[val] = node
        if first[val] == nil {
            first[val] = node
        }
    }
    
    func inc(_ key: String) {
        if map[key] == nil { // 当前 key 不存在，插入到链表末尾
            let node = ListNode.init(key, 1)
            map[key] = node
            insert(tail.prev!, tail, node) // 插入
            if first[1] == nil {
                newFirst(1, node) // 更新first
            }
            newLast(1, node) // 更新last
        } else {
            let node = map[key]!
            let val = node.val // 旧值
            let newVal = val + 1 // 新值
            let firstNode = first[val]! // 链表中第一个值为val的节点
            let lastNode = last[val]! // 链表中最后一个值为val的节点
            
            // 1. 找位置
            node.val = newVal
            if firstNode.hashValue == lastNode.hashValue { // 当前节点是唯一一个值为val的节点
                first.removeValue(forKey: val)
                last.removeValue(forKey: val)
                newLast(newVal, node) // 更新last
            } else if node.hashValue == firstNode.hashValue  { // 该节点是链表中第一个值为val的节点
                // 不动
                newLast(newVal, node)
                newFirst(val, node.next!)
            } else {
                if node.hashValue == lastNode.hashValue {
                    newLast(val, node.prev!) // 是最后一个值val的节点
                }
                // 这个时候，节点应该移动到链表中第一个值为val的节点之前
                move(node, firstNode.prev!, firstNode)
                newLast(newVal, node)
            }
        }
    }
    
    func dec(_ key: String) {
        guard let node = map[key] else {
            return
        }
        let val = node.val
        let newVal = val - 1
        let firstNode = first[val]!
        let lastNode = last[val]!
        
        if val == 1 { // 值为1，删除这个节点
            if firstNode.hashValue == lastNode.hashValue { // 没有值为1的节点了
                first.removeValue(forKey: val)
                last.removeValue(forKey: val)
            } else if node.hashValue == firstNode.hashValue { // 起始值右移
                first[val] = node.next
            } else if node.hashValue == lastNode.hashValue { // 终止值左移
                last[1] = node.prev
            }
            remove(node)
            map.removeValue(forKey: key)
        } else {
            node.val = newVal
            if firstNode.hashValue == lastNode.hashValue { // 唯一值为val的节点
                // 位置不变，成为newVal的首位
                first.removeValue(forKey: val)
                last.removeValue(forKey: val)
                newFirst(newVal, node)
            } else if node.hashValue == lastNode.hashValue { // 最后一项val值的节点
                // 位置不变，成为newVal的首位，并且prev成为val的最后一位
                newFirst(newVal, node)
                newLast(val, node.prev!)
            } else {
                if node.hashValue == firstNode.hashValue {
                    newFirst(val, node.next!) // 是第一项val值的节点
                }
                move(node, lastNode, lastNode.next!) // 移动到lastNode之后
                newFirst(newVal, node)
            }
        }
    }
    
    func getMaxKey() -> String {
        return head.next?.hashValue == tail.hashValue ? "" : head.next!.key
    }
    
    func getMinKey() -> String {
        return tail.prev?.hashValue == head.hashValue ? "" : tail.prev!.key
    }
}

/**
 * Your AllOne object will be instantiated and called as such:
 * let obj = AllOne()
 * obj.inc(key)
 * obj.dec(key)
 * let ret_3: String = obj.getMaxKey()
 * let ret_4: String = obj.getMinKey()
 */
