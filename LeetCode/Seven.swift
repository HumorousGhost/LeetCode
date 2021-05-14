//
//  Seven.swift
//  LeetCode
//
//  Created by UED on 2021/5/13.
//

import Cocoa

class Seven: NSObject {
    // 70. 爬楼梯
    func climbStairs(_ n: Int) -> Int {
        var p = 0, q = 0, r = 1
        for _ in 1...n {
            p = q
            q = r
            r = p + q
        }
        return r
    }
    
    // 71. 简化路径
    func simplifyPath(_ path: String) -> String {
        var stack = [String](repeating: "", count: 0) // 用栈来模拟
        let pathArr = path.split(separator: "/") // 用 / 分割，多个 / 也视为 /
        // 遍历
        for str in pathArr {
            // 如果等于 .. ，那就要返回上一级目录，因此栈中弹出当前目录
            // 此时栈可能是空
            if str == ".." {
                if !stack.isEmpty {
                    stack.removeLast()
                }
                continue
            } else if str == "." {
                continue
            }
            // 否则，栈中压入当前目录
            stack.append(String(str))
        }

        var string = ""
        // 使用的毕竟是数组，将数组循环
        for str in stack {
            string = string + "/" + str
        }
        if stack.count == 0 {
            string = "/"
        }
        return string
    }
}
