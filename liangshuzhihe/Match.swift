//
//  Match.swift
//  liangshuzhihe
//
//  Created by UED on 2020/11/13.
//

import Foundation

class Match: NSObject {
    // 正则表达式匹配
    func isMatch(_ s: String, _ p: String) -> Bool {
        if s.count > 20 || p.count > 30 {
            return false;
        }
        
        func matches(_ s1: String, _ p1: String) -> Bool {
            if p1 == "." {
                return true;
            }
            return s1 == p1;
        }
        
        let m = s.count;
        let n = p.count;
        
        var f = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1);
        f[0][0] = true;
        let sChars = s.map{String($0)};
        let pChars = p.map{String($0)};
        for i in 0..<sChars.count + 1 {
            for j in 1..<pChars.count + 1 {
                if pChars[j - 1] == "*" {
                    f[i][j] = f[i][j - 2];
                    if i != 0 && matches(sChars[i - 1], pChars[j - 2]) {
                        f[i][j] = f[i][j] || f[i - 1][j];
                    }
                } else {
                    if i != 0 && matches(sChars[i - 1], pChars[j - 1]) {
                        f[i][j] = f[i - 1][j - 1];
                    }
                }
            }
        }
        return f[m][n];
    }
    
    // 盛最多水的容器
    func maxArea(_ height: [Int]) -> Int {
        var l = 0;
        var r = height.count - 1;
        var ans = 0;
        while l < r {
            let area = min(height[l], height[r]) * (r - l);
            ans = max(ans, area);
            if height[l] <= height[r] {
                l += 1;
            } else {
                r -= 1;
            }
        }
        return ans;
    }
    
    // 整数转罗马数字
    func intToRoman(_ num: Int) -> String {
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        let symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        var value = "";
        var number = num;
        for i in 0..<values.count {
            if num < 0 {
                break;
            }
            while values[i] <= number {
                number -= values[i];
                value.append(symbols[i]);
            }
        }
        return value;
    }
    
    // 罗马数字转整数
    func romanToInt(_ s: String) -> Int {
        func getValue(_ str: String) -> Int {
            switch str {
            case "I":
                return 1;
            case "V":
                return 5;
            case "X":
                return 10;
            case "L":
                return 50;
            case "C":
                return 100;
            case "D":
                return 500;
            case "M":
                return 1000;
            default:
                return 0;
            }
        }
        
        var sum = 0;
        let sArray = s.map{String($0)};
        var perNum = getValue(sArray[0]);
        for i in 1..<s.count {
            let num = getValue(sArray[i]);
            if perNum < num {
                sum -= perNum;
            } else {
                sum += perNum;
            }
            perNum = num;
        }
        sum += perNum;
        return sum;
    }
    
    // 最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        func longestCommonPrefix(_ str1: String, _ str2: String) -> String {
            let length = min(str1.count, str2.count);
            var index = 0;
            let strArr1 = str1.map{String($0)};
            let strArr2 = str2.map{String($0)};
            while index < length && strArr1[index] == strArr2[index] {
                index += 1;
            }
            let ind = str1.index(str1.startIndex, offsetBy: index);
            return str1.substring(to: ind);
        }
        
        if strs.count == 0 {
            return "";
        }
        var prefix = strs[0];
        for i in 1..<strs.count {
            prefix = longestCommonPrefix(prefix, strs[i]);
            if prefix.count == 0 {
                break;
            }
        }
        return prefix;
    }
    
    // 三数之和
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let numsSort = nums.sorted();
        var ans = [[Int]]();
        let n = numsSort.count;
        for i in 0..<n {
            // 需要和上一次枚举的数不同
            if i > 0 && numsSort[i] == numsSort[i - 1] {
                continue;
            }
            // c 对应的指针初始指向数组的最右端
            var k = n - 1;
            let target = -numsSort[i];
            // 枚举b
            for j in i + 1..<n {
                // 需要和上一次枚举的数不同
                if j > i + 1 && numsSort[j] == numsSort[j - 1] {
                    continue;
                }
                // 需要保证 b 的指针在 c 的指针的左侧
                while j < k && numsSort[j] + numsSort[k] > target  {
                    k -= 1;
                }
                // 如果指针重合，随着 b 后续的增加，就不会有满足 a+b+c=0，并且 b<c 的 c 了，可以退出循环
                if j == k {
                    break;
                }
                if numsSort[j] + numsSort[k] == target {
                    var list = [Int]();
                    list.append(numsSort[i]);
                    list.append(numsSort[j]);
                    list.append(numsSort[k]);
                    ans.append(list);
                }
            }
        }
        return ans;
    }
    
    // 凉凉交换链表中的节点
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
}
