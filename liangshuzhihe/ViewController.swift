//
//  ViewController.swift
//  liangshuzhihe
//
//  Created by UED on 2020/10/30.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let list = ListNode.init(1, ListNode.init(2, ListNode.init(3, ListNode.init(4, ListNode.init(5)))));
        let haystack = "abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababab"
        let needle = ["ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba","ab","ba"]
        let result = Str().findSubstring(haystack, needle)
        print(result)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var sumArr = [Int]();
        var hash = [Int: Int]();
        for (index, value) in nums.enumerated() {
            if hash.keys.contains(value) {
                sumArr.append(index);
                sumArr.append(hash[value] ?? 0);
                return sumArr;
            }
            // 将数据存入 key为补数 value为下标
            hash.updateValue(index, forKey: target - value);
        }
        return sumArr;
    }

    // 两数相加
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let root = ListNode.init(0);
        var cursor = root;
        var carry = 0;
        var list1 = l1;
        var list2 = l2;
        while (list1 != nil || list2 != nil || carry != 0) {
            let l1Val: Int = list1?.val ?? 0;
            let l2Val: Int = list2?.val ?? 0;
            let sumVal = l1Val + l2Val + carry;
            carry = sumVal / 10;
            
            let sumMode = ListNode.init(sumVal % 10);
            cursor.next = sumMode;
            cursor = sumMode;
            
            if list1 != nil {
                list1 = list1?.next;
            }
            if list2 != nil {
                list2 = list2?.next
            }
            
        }
        return root.next;
    }
    
    // 无重复字符的最长子串
    func lengthOfLongestSubString(_ s: String) -> Int {
        if s.count == 0 {
            return 0;
        }
        
        var map = [String: Int]();
        var maxs = 0;
        var left = 0;
        let stringArray = s.map{ $0 };
        
        for (i, sub) in stringArray.enumerated() {
            if map.keys.contains(String(sub)) {
                left = max(left, (map[String(sub)]! + 1));
            }
            map.updateValue(i, forKey: String(sub));
            maxs = max(maxs, i - left + 1);
        }
        return maxs;
    }

    // 寻找两个正序数组的中位数
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        func findKth(_ numsSub1: [Int], _ i: Int, _ numsSub2: [Int], _ j: Int, _ k: Int) -> Int {
            if i >= numsSub1.count {
                return numsSub2[j + k - 1]; // numsSub1为空数组
            }
            if j >= numsSub2.count {
                return numsSub1[i + k - 1];
            }
            if k == 1 {
                return min(numsSub1[i], numsSub2[j]);
            }
            let midVal1 = (i + k / 2 - 1 < numsSub1.count) ? numsSub1[i + k / 2 - 1] : Int.max;
            let midVal2 = (j + k / 2 - 1 < numsSub2.count) ? numsSub2[j + k / 2 - 1] : Int.max;
            if midVal1 < midVal2 {
                return findKth(numsSub1, i + k / 2, numsSub2, j, k - k / 2);
            } else {
                return findKth(numsSub1, i, numsSub2, j + k / 2, k - k / 2);
            }
        }
        
        let m = nums1.count;
        let n = nums2.count;
        let left : Int = (m + n + 1) / 2;
        let right : Int = (m + n + 2) / 2;
        return Double((findKth(nums1, 0, nums2, 0, left) + findKth(nums1, 0, nums2, 0, right))) / 2.0;
    }
    
    // 最长回文子串
    func longesPalindrome(_ s: String) -> String {
        
        func findLongest(_ str: [String], _ low: inout Int, _ range: inout [Int]) -> Int {
            
            // 查找中间部分
            var high = low;
            while (high < str.count - 1 && str[high + 1] == str[low]) {
                high += 1;
            }
            // 定位中间部分的最后一个字符
            let ans = high;
            // 从中间向左右扩散
            while (low > 0 && high < str.count - 1 && str[low - 1] == str[high + 1]) {
                low -= 1;
                high += 1;
            }
            // 记录最大长度
            if high - low > range[1] - range[0] {
                range[0] = low;
                range[1] = high;
            }
            return ans;
        }
        
        let stringArray = s.map{ String($0) };
        // 保存起始位置，测试了用数组似乎能比全局变量稍快一点
        var range = [Int](repeating: 0, count: 2);
        for var i in 0..<s.count {
            // 把回文看成中间的部分全是同一字符，左右部分相对称
            // 找到下一个与当前字符不同的字符
            i = findLongest(stringArray, &i, &range);
        }
        let indexStart = s.index(s.startIndex, offsetBy: range[0])
        let indexEnd = s.index(s.startIndex, offsetBy: range[1] + 1);
        return String(s[indexStart..<indexEnd]);
    }
    
    // Z 字形变换
    func convert(_ s: String, _ numRows: Int) -> String {
        
        if numRows == 1 {
            return s;
        }
        let n = s.count;
        let strArray = s.map{String($0)};
        var stringArray = [String](repeating: "", count: numRows);
        var flag = 0;
        var index = 0;
        for i in 0..<n {
            if flag == 0 {
                stringArray[index].append(strArray[i]);
                index += 1;
                if index == numRows - 1 {
                    flag = 1;
                }
            } else {
                stringArray[index].append(strArray[i]);
                index -= 1;
                if index == 0 {
                    flag = 0
                }
            }
        }
        return stringArray.joined();
    }
    
    // 整数反转
    func reverse(_ x: Int) -> Int {
        let str = String(x);
        if str.count == 1 {
            return x;
        }
        var string = "";
        var stringArray: [String] = str.map{String($0)};
        var fuhao = "";
        if stringArray[0] == "-" {
            fuhao = "-";
            stringArray[0] = "";
        }
        
        for value in stringArray {
            string.insert(contentsOf: value, at: string.startIndex);
        }
        string.insert(contentsOf: fuhao, at: string.startIndex);
        let value = Int(string) ?? 0;
        if value > ((1<<31) - 1) || value < -(1<<31) {
            return 0;
        }
        return value;
    }
    
    // 字符串转换整数(atoi)
    func myAtoi(_ s: String) -> Int {
        let chars = s.map{String($0)};
        let n = chars.count;
        var idx = 0;
        while idx < n && chars[idx] == " " {
            // 去掉面的空格
            idx += 1;
        }
        if idx == n {
            return 0;
        }
        var negative = false;
        if chars[idx] == "-" {
            // 遇到负号
            negative = true;
            idx += 1;
        } else if chars[idx] == "+" {
            // 遇到正号
            idx += 1;
        } else if !Character.init(chars[idx]).isNumber {
            return 0;
        }
        var ans = 0;
        while idx < n && Character.init(chars[idx]).isNumber {
            guard let digit = Int(chars[idx]) else { return 0 };
            if ans > ((1<<31) - 1 - digit) / 10 {
                return negative ? -(1<<31) : (1<<31) - 1;
            }
            ans = ans * 10 + digit;
            idx += 1;
        }
        if ans > (1<<31) - 1 || -ans < -(1<<31) {
            return negative ? -(1<<31) : (1<<31) - 1;
        }
        return negative ? -ans : ans;
    }
    
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() {
        self.val = 0;
        self.next = nil;
    }
    public init(_ val: Int) {
        self.val = val;
        self.next = nil;
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next;
    }
}

