//
//  TwentyFour.swift
//  LeetCode
//
//  Created by UED on 2021/7/30.
//

import Foundation

class TwentyFour {
    // 240. 搜索二维矩阵 II
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let n = matrix[0].count
        var list = [Int]()
        for (index, value) in matrix.enumerated() {
            if value[0] == target || target == value[n - 1] {
                return true
            } else if value[0] < target && target < value[n - 1] {
                list.append(index)
            }
        }
        
        for i in list {
            let nums = matrix[i]
            var left = 0, right = n - 1, mid = (left + right) / 2
            while left <= right {
                if nums[mid] == target {
                    return true
                } else if target < nums[mid] {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
                mid = (left + right) / 2
            }
        }
        
        return false
    }
    
    // 241. 为运算表达式设计优先级
    func diffWaysToCompute(_ expression: String) -> [Int] {
        let facAry = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]
        
        let mark = 100000
        var opIdxDic = [Int: String]()
        
        func deCantor(ct: Int, n: Int) -> [Int] {
            if n <= 0 {
                return []
            }
            
            var optAry = Array.init(repeating: 0, count: n)
            var numAry = Array.init(repeating: 0, count: n)
            for i in 0..<n {
                numAry[i] = i
            }
            
            var x = ct
            for i in 1...n {
                let r = x % facAry[n - i]
                let t = x / facAry[n - i]
                x = r
                optAry[i - 1] = numAry[t]
                numAry.remove(at: t)
            }
            
            return optAry
        }
            
        var ipt = ""
        for char in expression {
            if char == "+" || char == "-" || char == "*" {
                let idx = mark + opIdxDic.count
                let ope = String(char)
                ipt += String(format: ",%d,", idx)
                opIdxDic[idx] = ope
                continue
            }
            ipt += String(char)
        }
        let numAry = ipt.components(separatedBy: ",").map { Int($0) ?? 0 }
            
        var optDic = [String: Int]()
        let len = facAry[opIdxDic.count]
        for i in 0..<len {
            var subNumAry = numAry
            var subStrAry = subNumAry.map { String($0) }
            
            for opIdx in deCantor(ct: i, n: opIdxDic.count) {
                for j in 0..<subNumAry.count {
                    let op = subNumAry[j]
                    if op != mark + opIdx {
                        continue
                    }
                        
                    let numL = subNumAry[j - 1], numR = subNumAry[j + 1]
                    let strL = subStrAry[j - 1], strR = subStrAry[j + 1]
                    var num = 0
                    var str = ""
                    switch opIdxDic[subNumAry[j]] {
                    case "+":
                        num = numL + numR
                        str = "(" + strL + "+" + strR + ")"
                    case "-":
                        num = numL - numR
                        str = "(" + strL + "-" + strR + ")"
                    case "*":
                        num = numL * numR
                        str = "(" + strL + "*" + strR + ")"
                    default: break
                    }
                    for _ in 0..<2 {
                        subNumAry.remove(at: j - 1)
                        subStrAry.remove(at: j - 1)
                    }
                    subNumAry[j - 1] = num
                    subStrAry[j - 1] = str
                    break
                }
            }
            
            optDic[subStrAry[0]] = subNumAry[0]
        }
            
        var optAry = [Int]()
        for kv in optDic {
                optAry.append(kv.value)
        }
        return optAry.sorted()
    }
    
}
