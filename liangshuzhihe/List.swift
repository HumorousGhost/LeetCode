//
//  List.swift
//  liangshuzhihe
//
//  Created by UED on 2020/12/11.
//

import Foundation

class List : NSObject {
    // 合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummyHead = ListNode.init(0);
        var cur = dummyHead;
        var newL1 = l1;
        var newL2 = l2;
        while newL1 != nil && newL2 != nil {
            if newL1!.val < newL2!.val {
                cur.next = newL1;
                newL1 = newL1!.next;
            } else {
                cur.next = newL2!;
                newL2 = newL2?.next;
            }
            cur = cur.next!;
        }
        // 任一为空，直接连接另一条链表
        cur.next = newL1 == nil ? newL2 : newL1;
        return dummyHead.next;
    }
    
    // 括号生成
    func generateParenthesis(_ n: Int) -> [String] {
        func backtrack(ans: inout [String], cur: String, open: Int, close: Int, max: Int) -> Void {
            var curStr = cur;
            if curStr.count == max * 2 {
                ans.append(curStr);
                return;
            }
            if open < max {
                curStr.append("(");
                backtrack(ans: &ans, cur: curStr, open: open + 1, close: close, max: max);
                curStr.removeLast();
            }
            if close < open {
                curStr.append(")");
                backtrack(ans: &ans, cur: curStr, open: open, close: close + 1, max: max);
                curStr.removeLast();
            }
        }
        var ans = [String]();
        backtrack(ans: &ans, cur: "", open: 0, close: 0, max: n);
        return ans;
    }
    
    // 合并k个升序链表
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        // 合并两个链表
        func mergeTwoLists(_ a: ListNode?, _ b: ListNode? ) -> ListNode? {
            if a == nil || b == nil {
                return a != nil ? a : b;
            }
            // 用于保存链表
            let head = ListNode.init(0);
            // 记录下一个插入位置的前一个位置
            var tail = head;
            // a链表未合并的第一位
            var aPtr = a;
            // b链表未合并的第一位
            var bPtr = b;
            while aPtr != nil && bPtr != nil {
                if aPtr!.val < bPtr!.val {
                    tail.next = aPtr;
                    aPtr = aPtr?.next;
                } else {
                    tail.next = bPtr;
                    bPtr = bPtr?.next;
                }
                tail = tail.next!;
            }
            tail.next = (aPtr != nil ? aPtr : bPtr);
            return head.next;
        }
        
        /// 二路归并
        func merge(_ lists: [ListNode?], _ l: Int, _ r: Int) -> ListNode? {
            if l == r {
                return lists[l];
            }
            if l > r {
                return nil;
            }
            let mid = (l + r) >> 1;
            return mergeTwoLists(merge(lists, l, mid), merge(lists, mid + 1, r));
        }
        
        return merge(lists, 0, lists.count - 1);
    }
    
    /// k个一组翻转链表
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        func myReverse(_ head: ListNode?, _ tail: ListNode?) -> [ListNode?] {
            var prev = tail?.next;
            var p = head;
            while prev !== tail {
                let nex = p?.next;
                p?.next = prev;
                prev = p;
                p = nex;
            }
            return [tail, head];
        }
        
        var newHead = head;
        let hair = ListNode.init(0);
        hair.next = newHead;
        var pre = hair;
        while newHead != nil {
            var tail = pre;
            for _ in 0..<k {
//                tail = tail.next;
                if tail.next == nil {
                    return hair.next;
                }
                tail = tail.next!;
            }
            let nex = tail.next;
            let reverse = myReverse(newHead, tail);
            newHead = reverse[0];
            tail = reverse[1]!;
            // 把子链表重新接回原链表
            pre.next = newHead;
            tail.next = nex;
            pre = tail;
            newHead = tail.next;
        }
        return hair.next;
    }
    
    /// 删除排序数组中的重复项
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0;
        }
        var i = 0;
        for j in 1..<nums.count {
            if nums[j] != nums[i] {
                i += 1;
                nums[i] = nums[j];
            }
        }
        return i + 1;
    }
}
