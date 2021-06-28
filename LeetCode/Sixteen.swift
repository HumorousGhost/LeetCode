//
//  Sixteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/24.
//

import Cocoa

class Sixteen {
    // 160. 相交链表
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil {
            return nil
        }
        
        func address(_ obj: Any?) -> Int {
            let point = Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque()
            return point.hashValue
        }
        
        var pA = headA, pB = headB
        while address(pA) != address(pB) {
            pA = pA == nil ? headB : pA?.next
            pB = pB == nil ? headA : pB?.next
        }
        return pA
    }
    
    // 162. 寻找峰值
    func findPeakElement(_ nums: [Int]) -> Int {
        var nums = nums
        nums.insert(Int.min, at: 0)
        nums.append(Int.min)
        for i in 1..<nums.count - 1 {
            if nums[i] > nums[i - 1] && nums[i] > nums[i + 1] {
                return i - 1
            }
        }
        return Int.min
    }
    
    // 164. 最大间距
    func maximumGap(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return 0
        }
        
        let minValue = nums.min()!
        let maxValue = nums.max()!
        
        let d = max(1, (maxValue - minValue) / (nums.count - 1))
        let bucketSize = ((maxValue - minValue) / d) + 1
        // 存储（桶内最小值，桶内最大值）对，（-1， -1）表示该桶是空的
        var bucket = [[Int]](repeating: [-1, -1], count: bucketSize)
        
        for i in 0..<nums.count {
            let idx = (nums[i] - minValue) / d
            if bucket[idx][0] == -1 {
                bucket[idx][0] = nums[i]
                bucket[idx][1] = nums[i]
            } else {
                bucket[idx][0] = min(bucket[idx][0], nums[i])
                bucket[idx][1] = max(bucket[idx][1], nums[i])
            }
        }
        
        var res = 0
        var prev = -1
        for i in 0..<bucketSize {
            if bucket[i][0] == -1 {
                continue
            }
            if prev != -1 {
                res = max(res, bucket[i][0] - bucket[prev][1])
            }
            prev = i
        }
        
        return res
    }
    
    // 165. 比较版本号
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        
        func getNextChunk(_ version: String, _ n: Int, _ p: Int) -> (Int, Int) {
            // if pointer is set to the end of string
            // return 0
            if p > n - 1 {
                return (0, p)
            }
            
            let versionArr = version.map { String($0) }
            
            // find the end of chunk
            var i = 0, p = p, pEnd = p
            while pEnd < n && versionArr[pEnd] != "." {
                pEnd += 1
            }
            
            // retrieve the chunk
            if pEnd != n - 1 {
                i = (versionArr[p..<pEnd].joined() as NSString).integerValue
            } else {
                i = (versionArr[p..<n].joined() as NSString).integerValue
            }
            
            // find the beginning of next chunk
            p = pEnd + 1
            return (i, p)
        }
        
        var p1 = 0, p2 = 0
        let n1 = version1.count, n2 = version2.count
        
        // compare versions
        var i1 = 0, i2 = 0
        while p1 < n1 || p2 < n2 {
            (i1, p1) = getNextChunk(version1, n1, p1)
            
            (i2, p2) = getNextChunk(version2, n2, p2)
            
            if i1 != i2 {
                return i1 > i2 ? 1 : -1
            }
        }
        
        // the versions are equal
        return 0
    }
    
    // 166. 分数到小数
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 {
            return "0"
        }
        
        var fraction = [String]()
        // If either one is negative (not both)
        if (numerator < 0 && denominator > 0) || (numerator > 0 && denominator < 0) {
            fraction.append("-")
        }
        // Convert to Int or else abs(-2147483648) overflows
        let dividend = abs(numerator)
        let divisor = abs(denominator)
        fraction.append("\(dividend / divisor)")
        var remainder = dividend % divisor
        if remainder == 0 {
            return fraction.joined()
        }
        fraction.append(".")
        var map = [Int: Int]()
        while remainder != 0 {
            if map.keys.contains(remainder) {
                fraction.insert("(", at: map[remainder]!)
                fraction.append(")")
                break
            }
            map[remainder] = fraction.count
            remainder *= 10
            fraction.append("\(remainder / divisor)")
            remainder %= divisor
        }
        return fraction.joined()
    }
    
    // 167. 两数之和 II - 输入有序数组
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var low = 0, high = numbers.count - 1
        while low < high {
            let sum = numbers[low] + numbers[high]
            if sum == target {
                return [low + 1, high + 1]
            } else if sum < target {
                low += 1
            } else {
                high -= 1
            }
        }
        return [-1, -1]
    }
    
    // 168. Excel表列名称
    func convertToTitle(_ columnNumber: Int) -> String {
        
        func title(_ number: Int) -> String {
            switch number {
            case 1:
                return "A"
            case 2:
                return "B"
            case 3:
                return "C"
            case 4:
                return "D"
            case 5:
                return "E"
            case 6:
                return "F"
            case 7:
                return "G"
            case 8:
                return "H"
            case 9:
                return "I"
            case 10: return "J"
            case 11: return "K"
            case 12: return "L"
            case 13: return "M"
            case 14: return "N"
            case 15: return "O"
            case 16: return "P"
            case 17: return "Q"
            case 18: return "R"
            case 19: return "S"
            case 20: return "T"
            case 21: return "U"
            case 22: return "V"
            case 23: return "W"
            case 24: return "X"
            case 25: return "Y"
            case 26: return "Z"
            default:
                return "Z"
            }
        }
        
        if columnNumber <= 26 {
            return title(columnNumber)
        }
        var number = columnNumber
        var res = ""
        while number > 26 {
            let r = number % 26
            if r == 0 {
                number = number / 26 - 1
            } else {
                number /= 26
            }
            res = title(r) + res
        }
        res = title(number) + res
        return res
    }
}
