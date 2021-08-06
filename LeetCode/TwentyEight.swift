//
//  TwentyEight.swift
//  LeetCode
//
//  Created by UED on 2021/8/5.
//

import Foundation

class TwentyEight {
    // 282. 给表达式添加运算符
    func addOperators(_ num: String, _ target: Int) -> [String] {
        
        var result = [String]()
        let numStr = num.map({String($0)})
        let count = num.count
        
        func help(_ curRes: Int, _ diff: Int, _ start: Int, _ curExp: String) {
            if start == count && target == curRes {
                result.append(curExp)
            }
            
            for i in start..<count {
                let curArr = numStr[start..<i + 1]
                if curArr.count > 1 && curArr.first == "0" {
                    break
                }
                
                let cur = curArr.joined()
                
                if curExp.count > 0 {
                    help(curRes + Int(cur)!, Int(cur)!, i + 1, curExp + "+" + cur)
                    help(curRes - Int(cur)!, -Int(cur)!, i + 1, curExp + "-" + cur)
                    help((curRes - diff) + (diff * Int(cur)!), diff * Int(cur)!, i + 1, curExp + "*" + cur)
                } else {
                    help(Int(cur)!, Int(cur)!, i + 1, cur)
                }
            }
        }
        
        if num.count == 0 {
            return result
        }
        
        help(0, 0, 0, "")
        
        return result
    }
    
    // 283. 移动零
    func moveZeroes(_ nums: inout [Int]) {
        let count = nums.count
        var i = 0
        var index = 0
        while i < count && index < count {
            let num = nums[i]
            if num == 0 {
                nums.remove(at: i)
                nums.append(num)
            } else {
                i += 1
            }
            index += 1
        }
    }
}
