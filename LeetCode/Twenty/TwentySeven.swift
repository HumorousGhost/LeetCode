//
//  TwentySeven.swift
//  LeetCode
//
//  Created by UED on 2021/8/4.
//

import Foundation

class TwentySeven {
    // 273. 整数转换英文表示
    func numberToWords(_ num: Int) -> String {
        
        func one(_ num: Int) -> String {
            switch num {
            case 1:
                return "One"
            case 2: return "Two"
            case 3: return "Three"
            case 4: return "Four"
            case 5: return "Five"
            case 6: return "Six"
            case 7: return "Seven"
            case 8: return "Eight"
            case 9: return "Nine"
            default:
                return ""
            }
        }
        
        func twoLessThan20(_ num: Int) -> String {
            switch num {
            case 10: return "Ten"
            case 11: return "Eleven"
            case 12: return "Twelve"
            case 13: return "Thirteen"
            case 14: return "Fourteen"
            case 15: return "Fifteen"
            case 16: return "Sixteen"
            case 17: return "Seventeen"
            case 18: return "Eighteen"
            case 19: return "Nineteen"
            default:
                return ""
            }
        }
        
        func ten(_ num: Int) -> String {
            switch num {
            case 2: return "Twenty"
            case 3: return "Thirty"
            case 4: return "Forty"
            case 5: return "Fifty"
            case 6: return "Sixty"
            case 7: return "Seventy"
            case 8: return "Eighty"
            case 9: return "Ninety"
            default:
                return ""
            }
        }
        
        func two(_ num: Int) -> String {
            if num == 0 {
                return ""
            } else if num < 10 {
                return one(num)
            } else if num < 20 {
                return twoLessThan20(num)
            } else {
                let tenner = num / 10
                let rest = num - tenner * 10
                if rest != 0 {
                    return "\(ten(tenner)) \(one(rest))"
                } else {
                    return ten(tenner)
                }
            }
        }
        
        func three(_ num: Int) -> String {
            let hundred = num / 100
            let rest = num - hundred * 100
            var res = ""
            if hundred * rest != 0 {
                res = "\(one(hundred)) Hundred \(two(rest))"
            } else if hundred == 0 && rest != 0 {
                res = two(rest)
            } else if hundred != 0 && rest == 0 {
                res = one(hundred) + " Hundred"
            }
            return res
        }
        
        guard num != 0 else {
            return "Zero"
        }
        
        let billion = num / 1000000000
        let million = (num - billion * 1000000000) / 1000000
        let thousand = (num - billion * 1000000000 - million * 1000000) / 1000
        let rest = num - billion * 1000000000 - million * 1000000 - thousand * 1000
        
        var result = ""
        if billion != 0 {
            result += "\(three(billion)) Billion"
        }
        if million != 0 {
            if !result.isEmpty {
                result += " "
            }
            result += "\(three(million)) Million"
        }
        if thousand != 0 {
            if !result.isEmpty {
                result += " "
            }
            result += "\(three(thousand)) Thousand"
        }
        if rest != 0 {
            if !result.isEmpty {
                result += " "
            }
            result += three(rest)
        }
        
        return result
    }
    
    // 274. H 指数
    func hIndex(_ citations: [Int]) -> Int {
        let nums = citations.sorted()
        var h = 0, i = nums.count - 1
        while i >= 0 && nums[i] > h {
            h += 1
            i -= 1
        }
        return h
    }
    
    // 275. H 指数 II
    func hIndex2(_ citations: [Int]) -> Int {
        let count = citations.count
        var left = 0, right = count - 1
        while left <= right {
            let mid = (left + right) / 2
            if citations[mid] >= count - mid {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return count - left
    }
    
    // 278. 第一个错误的版本
    func firstBadVersion(_ n: Int) -> Int {
        /**
         * The knows API is defined in the parent class VersionControl.
         */
        func isBadVersion(_ version: Int) -> Bool {
            return true
        }
        
        var left = 1, right = n
        while left < right { // 循环至区间左右端点相同
            let mid = (left + right) / 2
            if isBadVersion(mid) {
                right = mid // 答案在区间 [left, mid] 中
            } else {
                left = mid + 1 // 答案在区间 [mid + 1, right] 中
            }
        }
        // 此时有 left == right, 区间缩为一个点，即为答案
        return left
    }
    
    // 279. 完全平方数
    func numSquares(_ n: Int) -> Int {
        // 判断是否为完全平方数
        func isPerfectSquare(_ x: Int) -> Bool {
            let y = Int(sqrt(Double(x)))
            return y * y == x
        }
        
        // 判断是否能表示未 4^k *(8m + 7)
        func checkAnswer4(_ x: Int) -> Bool {
            var x = x
            while x % 4 == 0 {
                x /= 4
            }
            return x % 8 == 7
        }
        
        if isPerfectSquare(n) {
            return 1
        }
        
        if checkAnswer4(n) {
            return 4
        }
        
        var i = 1
        while i * i <= n {
            let j = n - i * i
            if isPerfectSquare(j) {
                return 2
            }
            i += 1
        }
        return 3
    }
}
