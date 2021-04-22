//
//  Two.swift
//  liangshuzhihe
//
//  Created by UED on 2021/4/22.
//

import Cocoa

class Two: NSObject {
    // 11. 盛最多水的容器
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
    
    // 12. 整数转罗马数字
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
    
    // 13. 罗马数字转整数
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
    
    // 14. 最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        func longestCommonPrefix(_ str1: String, _ str2: String) -> String {
            let length = min(str1.count, str2.count);
            var index = 0;
            let strArr1 = str1.map{String($0)};
            let strArr2 = str2.map{String($0)};
            while index < length && strArr1[index] == strArr2[index] {
                index += 1;
            }
//            let ind = str1.index(str1.startIndex, offsetBy: index);
            return (str1 as NSString).substring(to: index);
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
    
    // 15. 三数之和
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
    
    // 16. 最接近的三数之和
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let numsSort = nums.sorted();
        let n = numsSort.count;
        var best = 100000000;
        // 枚举 a
        for i in 0..<n {
            // 保证和上一次枚举的元素不相等
            if i > 0 && numsSort[i] == numsSort[i - 1] {
                continue;
            }
            var j = i + 1;
            var k = n - 1;
            while j < k {
                let sum = numsSort[i] + numsSort[j] + numsSort[k];
                // 如果和为target直接返回答案
                if sum == target {
                    return target;
                }
                // 根据差值的绝对值来更新答案
                if abs(sum - target) < abs(best - target) {
                    best = sum;
                }
                if sum > target {
                    // 如果和大于target，移动k值，即右侧指针
                    var tempK = k - 1;
                    // 移动到下一个不相等的元素
                    while j < tempK && numsSort[tempK] == numsSort[k] {
                        tempK -= 1;
                    }
                    k = tempK;
                } else {
                    // 如果小于 target，移动j值，对应左侧指针。
                    var tempJ = j + 1;
                    // 移动到下一个不相等的元素
                    while tempJ < k && numsSort[tempJ] == numsSort[j] {
                        tempJ += 1;
                    }
                    j = tempJ;
                }
            }
        }
        return best;
    }
    
    // 17. 电话号码的字母组合
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count == 0 {
            return [];
        }
        // 递归循环
        func getStringArray(_ s: [[String]], _ i: Int, _ list: [String], _ stemp: String) -> [String] {
            var newList = list;
            var newI = i;
            let newS = s;
            if newI < s.count - 1 {
                for j in 0..<s[newI].count {
                    newList = getStringArray(newS, newI + 1, newList, stemp.appending(s[newI][j]));
                }
                newI += 1;
            } else {
                for j in 0..<newS[newI].count {
                    newList.append(stemp.appending(newS[newI][j]));
                }
            }
            return newList;
        }
        
        let numToComMap:[String: [String]] = ["1": [], "2": ["a", "b", "c"], "3": ["d", "e", "f"], "4": ["g", "h", "i"], "5": ["j", "k", "l"], "6": ["m", "n", "o"], "7": ["p", "q", "r", "s"], "8": ["t", "u", "v"], "9": ["w", "x", "y", "z"]];
        let digitsArray = digits.map{String($0)};
        var combinArr = [[String]]();
        for (_, value) in digitsArray.enumerated() {
            let tempCom = numToComMap[value];
            combinArr.append(tempCom ?? []);
        }
        var list = [String]();
        list = getStringArray(combinArr, 0, list, "");
        return list;
    }
    
    // 18. 四数之和
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 {
            return [];
        }
        let numsSort = nums.sorted();
        let n = numsSort.count;
        var array = [[Int]]();
        for i in 0..<n - 3 {
            if i > 0 && numsSort[i] == numsSort[i - 1] {
                continue;
            }
            // 如果4个数相加大于target时，跳出循环
            if numsSort[i] + numsSort[i + 1] + numsSort[i + 2] + numsSort[i + 3] > target {
                break;
            }
            // 如果4个数相加小于target时，结束当前某次循环
            if numsSort[i] + numsSort[n - 3] + numsSort[n - 2] + numsSort[n - 1] < target {
                continue;
            }
            for j in i + 1..<n - 2 {
                if j > i + 1 && numsSort[j] == numsSort[j - 1] {
                    continue;
                }
                if numsSort[i] + numsSort[j] + numsSort[j + 1] + numsSort[j + 2] > target {
                    break;
                }
                if numsSort[i] + numsSort[j] + numsSort[n - 2] + numsSort[n - 1] < target {
                    continue;
                }
                var left = j + 1;
                var right = n - 1;
                while left < right {
                    let sum = numsSort[i] + numsSort[j] + numsSort[left] + numsSort[right];
                    if sum == target {
                        array.append([numsSort[i], numsSort[j], numsSort[left], numsSort[right]]);
                        while left < right && numsSort[left] == numsSort[left + 1] {
                            left += 1;
                        }
                        left += 1;
                        while left < right && numsSort[right] == numsSort[right - 1] {
                            right -= 1;
                        }
                        right -= 1;
                    } else if sum < target {
                        left += 1;
                    } else {
                        right -= 1;
                    }
                }
            }
        }
        return array;
    }
    
    // 19. 删除链表的倒数第n个节点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode.init(0, head);
        var first = head;
        var second = dummy;
        for _ in 0..<n {
            first = first?.next;
        }
        while first != nil {
            first = first?.next;
            second = second.next!;
        }
        second.next = second.next?.next;
        return dummy.next;
    }
    
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
}
