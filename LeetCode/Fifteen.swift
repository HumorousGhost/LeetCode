//
//  Fifteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/22.
//

import Cocoa

class Fifteen: NSObject {
    // 150. 逆波兰表达式求值
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for token in tokens {
            if token == "+" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 + sum1)
            } else if token == "-" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 - sum1)
            } else if token == "*" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 * sum1)
            } else if token == "/" {
                let sum1 = stack.removeLast()
                let sum2 = stack.removeLast()
                stack.append(sum2 / sum1)
            } else {
                stack.append((token as NSString).integerValue)
            }
        }
        return stack.removeLast()
    }
    
    // 151. 翻转字符串里的单词
    func reverseWords(_ s: String) -> String {
        let sArr = s.components(separatedBy: " ")
        var newArr = [String]()
        for i in 0..<sArr.count {
            if sArr[i] != "" {
                newArr.insert(sArr[i], at: 0)
            }
        }
        return newArr.joined(separator: " ")
    }
}
