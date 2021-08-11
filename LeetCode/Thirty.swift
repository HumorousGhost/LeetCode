//
//  Thirty.swift
//  LeetCode
//
//  Created by UED on 2021/8/11.
//

import Foundation

class Thirty {
    // 300. 最长递增子序列
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        if nums.count == 1 {
            return 1
        }
        let count = nums.count
        var dp = [Int](repeating: 0, count: count)
        dp[0] = 1
        var maxans = 1
        for i in 1..<count {
            dp[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
            maxans = max(maxans, dp[i])
        }
        return maxans
    }
    
    // 301. 删除无效的括号
    func removeInvalidParentheses(_ s: String) -> [String] {
        
        func isVaild(_ s: String) -> Bool {
            var count = 0
            let strArray = [Character](s)
            for i in 0..<s.count {
                if strArray[i] == "(" {
                    count += 1
                } else if strArray[i] == ")" {
                    count -= 1
                }
                if count < 0 {
                    //出现只有右括号在前的case
                    return false
                }
            }
            return count == 0
        }

        var res = [String]()
        var queue = [String]()
        var visited = Set<String>()
                
        queue.append(s)
                
        while true {
            let size = queue.count
            //考虑当前层
            for _ in 0..<size {
                let str = queue.removeFirst()
                if isVaild(str) {
                    res.append(str)
                } else if res.isEmpty {
                    //生成下一层，原来的基础上再多删除一个括号
                    for removei in 0..<str.count {
                        let removeIndex = str.index(str.startIndex, offsetBy: removei)
                        if str[removeIndex] == "(" || str[removeIndex] == ")" {
                            var newstr = str
                            newstr.remove(at: removeIndex)
                            let nexts = newstr
                            //防止重复
                            if !visited.contains(nexts) {
                                queue.append(nexts)
                                visited.insert(nexts)
                            }
                        }
                    }
                }
            }
            //出现了合法字符串，终止循环
            if res.count > 0 {
                break
            }
        }
        
        return res
    }
}
