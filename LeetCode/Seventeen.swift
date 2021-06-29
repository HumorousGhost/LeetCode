//
//  Seventeen.swift
//  LeetCode
//
//  Created by UED on 2021/6/28.
//

import Cocoa

class Seventeen: NSObject {
    // 171. Excel表列序号
    func titleToNumber(_ columnTitle: String) -> Int {
        func number(_ title: String) -> Int {
            switch title {
            case "A": return 1
            case "B": return 2
            case "C": return 3
            case "D": return 4
            case "E": return 5
            case "F": return 6
            case "G": return 7
            case "H": return 8
            case "I": return 9
            case "J": return 10
            case "K": return 11
            case "L": return 12
            case "M": return 13
            case "N": return 14
            case "O": return 15
            case "P": return 16
            case "Q": return 17
            case "R": return 18
            case "S": return 19
            case "T": return 20
            case "U": return 21
            case "V": return 22
            case "W": return 23
            case "X": return 24
            case "Y": return 25
            case "Z": return 26
            default : return 0
            }
        }
        
        let titles = columnTitle.map { String($0) }
        var ans = 0
        var multiple = 1
        for i in 0..<titles.count {
            let index = titles.count - 1 - i
            let num = number(titles[index])
            ans += num * multiple
            multiple *= 26
        }
        
        return ans
    }
    
    // 172. 阶乘后的零
    func trailingZeroes(_ n: Int) -> Int {
        var zeroCount = 0
        var n = n
        while n > 0 {
            n /= 5
            zeroCount += n
        }
        return zeroCount
    }
}
