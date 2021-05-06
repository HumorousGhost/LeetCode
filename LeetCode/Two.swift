//
//  Two.swift
//  LeetCode
//
//  Created by UED on 2021/4/22.
//

import Cocoa

class Two: NSObject {
    // 20. 有效的括号
    func isValid(_ s: String) -> Bool {
        
        func isCorrespond(_ s1: String, _ s2: String) -> Bool {
            if s1 == "(" && s2 == ")" || s1 == "[" && s2 == "]" || s1 == "{" && s2 == "}" {
                return true;
            }
            return false;
        }
        
        var stack = [String]();
        let sArray = s.map{String($0)};
        for (_, value) in sArray.enumerated() {
            if stack.count == 0 {
                stack.append(value);
            } else if (isCorrespond(stack.last ?? "", value)) {
                stack.removeLast();
            } else {
                stack.append(value);
            }
        }
        return stack.count == 0;
    }
    
    // 21. 合并两个有序链表
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
    
    // 22. 括号生成
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
    
    // 23. 合并k个升序链表
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
    
    // 24. 两两交换链表中的节点
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummyHead = ListNode.init(0);
        dummyHead.next = head;
        var temp = dummyHead;
        while temp.next != nil && temp.next?.next != nil {
            let node1 = temp.next;
            let node2 = temp.next?.next;
            temp.next = node2;
            node1?.next = node2?.next;
            node2?.next = node1;
            temp = node1!;
        }
        return dummyHead.next;
    }
    
    /// 25. k个一组翻转链表
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
    
    /// 26. 删除排序数组中的重复项
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
    
    /// 27. 移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0;
        var n = nums.count;
        while i < n {
            if nums[i] == val {
                nums[i] = nums[n - 1];
                n -= 1;
            } else {
                i += 1;
            }
        }
        return n;
    }
    
    // 28. 实现 strStr() 函数 方法1
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        func charToInt(_ idx: Int, _ s: String) -> Int {
            let str = (s as NSString).substring(with: NSRange.init(location: idx, length: 1))
            let ascii = str.unicodeScalars[str.unicodeScalars.startIndex].value
            return Int(ascii - "a".unicodeScalars["a".unicodeScalars.startIndex].value)
        }
        
        let L = needle.count, n = haystack.count
        if L > n {
            return -1
        }
        
        // base value for the rolling hash function
        let a = 26
        // modulus value for the rolling hash function to avoid overflow
        let modulus = pow(2.0, 31.0)
        
        // compute the hash of strings haystack[L], needle[L]
        var h = 0, ref_h = 0
        for i in 0..<L {
            h = (h * a + charToInt(i, haystack)) % Int(modulus)
            ref_h = (ref_h * a + charToInt(i, needle)) % Int(modulus)
        }
        if h == ref_h {
            return 0
        }
        
        // count value to be used often : a**L % modulus
        var aL = 1
        for _ in 1...L {
            aL = (aL * a) % Int(modulus)
        }
        
        for start in 1..<n - L + 1 {
            // compute rolling hash in O(1) time
            h = (h * a - charToInt(start - 1, haystack) * aL + charToInt(start + L - 1, haystack)) % Int(modulus)
            if h == ref_h {
                return start
            }
        }
        return -1
    }
    
    // 28. 实现 strStr() 函数 方法2
    func strStr2(_ haystack: String, _ needle: String) -> Int {
        let m = haystack.count, n = needle.count
        if n > m {
            return -1
        }
        if n == 0 {
            return 0
        }
        for i in 0...m - n {
            for j in 0..<n {
                if (haystack as NSString).substring(with: NSRange.init(location: i + j, length: 1)) != (needle as NSString).substring(with: NSRange.init(location: j, length: 1)) {
                    break
                }
                if j == n - 1 {
                    return i
                }
            }
        }
        return -1
    }
    
    // 29. 两数相除
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if dividend == 0 {
            return 0
        }
        if dividend == Int.min && divisor == -1 {
            return Int.max
        }
        
        var negative: Bool
        negative = (dividend ^ divisor) < 0 // 用 异或来计算是否符号相同
        var t = abs(dividend)
        let d = abs(divisor)
        var result = 0
        let start = negative ? 0 : 1
        for i in start...31 {
            let a = 31 - i
            if (t >> a) >= d { // 找出足够大的数 2^n*divisor
                result += (1 << a) // 将结果加上2^n
                t -= (d << a) // 将被除数减去 2^n*divisor
            }
        }
        return negative ? -result : result // 符号相异取反
    }
}
