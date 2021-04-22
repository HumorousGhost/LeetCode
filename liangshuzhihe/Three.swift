//
//  Three.swift
//  liangshuzhihe
//
//  Created by UED on 2021/4/22.
//

import Cocoa

class Three: NSObject {
    // 最长有效括号
    func longestValidParentheses(_ s: String) -> Int {
        var maxans = 0
        var stack = [Int]()
        stack.append(-1)
        for i in 0..<s.count {
            if (s as NSString).substring(with: NSRange.init(location: i, length: 1)) == "(" {
                stack.append(i)
            } else {
                stack.removeLast()
                if stack.count == 0 {
                    stack.append(i)
                } else {
                    maxans = max(maxans, i - (stack.last ?? -1))
                }
            }
        }
        return maxans
    }
}
