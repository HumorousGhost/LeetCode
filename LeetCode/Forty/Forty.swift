//
//  Forty.swift
//  LeetCode
//
//  Created by UED on 2021/12/2.
//

import Foundation

class Forty {
    // 400. 第 N 位数字
    func findNthDigit(_ n: Int) -> Int {
        
        func totalDigits(_ length: Int) -> Int {
            var digits = 0, curLength = 1, curCount = 9
            while curLength <= length {
                digits += curLength * curCount
                curLength += 1
                curCount *= 10
            }
            return digits
        }
        
        var low = 1, high = 9
        while low < high {
            let mid = (high - low) / 2 + low
            if totalDigits(mid) < n {
                low = mid + 1
            } else {
                high = mid
            }
        }
        let d = low
        let prevDigits = totalDigits(d - 1)
        let index = n - prevDigits - 1
        let start = Int(pow(10.0, Double(d - 1)))
        let num = start + index / d
        let digitIndex = index % d
        let digit = (num / Int(pow(10.0, Double(d - digitIndex - 1)))) % 10
        return digit
    }
    
    // 401. 二进制手表
    func readBinaryWatch(_ turnedOn: Int) -> [String] {
        var ans = [String]()
        for h in 0..<12 {
            for m in 0..<60 {
                if h.nonzeroBitCount + m.nonzeroBitCount == turnedOn {
                    ans.append("\(h):\(m < 10 ? "0" : "")\(m)")
                }
            }
        }
        return ans
    }
    
    // 402. 移掉 K 位数字
    func removeKdigits(_ num: String, _ k: Int) -> String {
        var k = k
        var deque = [Character]()
        for digit in num {
            while !deque.isEmpty && k > 0 && deque.last! > digit {
                deque.removeLast()
                k -= 1
            }
            deque.append(digit)
        }
        
        for _ in 0..<k {
            deque.removeLast()
        }
        
        var ret = ""
        var leadingZero = true
        while !deque.isEmpty {
            let digit = deque.removeFirst()
            if leadingZero && digit == "0" {
                continue
            }
            leadingZero = false
            ret.append(digit)
        }
        return ret.count == 0 ? "0" : ret
    }
}
