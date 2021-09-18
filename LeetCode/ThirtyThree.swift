//
//  ThirtyThree.swift
//  LeetCode
//
//  Created by UED on 2021/9/9.
//

import Foundation

class ThirtyThree {
    // 330. 按要求补齐数组
    func minPatches(_ nums: [Int], _ n: Int) -> Int {
        var patches = 0
        var x = 1, index = 0
        let length = nums.count
        while x <= n {
            if index < length && nums[index] <= x {
                x += nums[index]
                index += 1
            } else {
                x *= 2
                patches += 1
            }
        }
        return patches
    }
    
    // 331. 验证二叉树的前序序列化
    func isValidSerialization(_ preorder: String) -> Bool {
        let preorderArray = preorder.map({ $0 })
        let n = preorder.count
        var i = 0
        var stack = [Int]()
        stack.append(1)
        while i < n {
            if stack.isEmpty {
                return false
            }
            if preorderArray[i] == "," {
                i += 1
            } else if preorderArray[i] == "#" {
                let top = stack.removeLast() - 1
                if top > 0 {
                    stack.append(top)
                }
                i += 1
            } else {
                // 读一个数字
                while i < n && preorderArray[i] != "," {
                    i += 1
                }
                let top = stack.removeLast() - 1
                if top > 0 {
                    stack.append(top)
                }
                stack.append(2)
            }
        }
        return stack.isEmpty
    }
    
    // 332. 重新安排行程
    func findItinerary(_ tickets: [[String]]) -> [String] {
        
        guard tickets.count > 0 && tickets[0].count > 0 else {
            return []
        }
        
        var map = [String : [String]]()
        var itineray = [String]()
        
        for ticket in tickets {
            let src = ticket[0], dst = ticket[1]
            if let _ = map[src] {
                map[src]!.append(dst)
            } else {
                map[src] = [dst]
            }
        }
        
        for ticket in tickets {
            let src = ticket[0]
            map[src] = map[src]?.sorted()
        }
        
        func dfs(_ current: String) {
            while map.keys.contains(current) && map[current]!.count > 0 {
                let temp = map[current]!.removeFirst()
                dfs(temp)
            }
            itineray.append(current)
        }
        
        dfs("JFK")
        return itineray.reversed()
    }
    
    // 334. 递增的三元子序列
    func increasingTriplet(_ nums: [Int]) -> Bool {
        guard nums.count >= 3 else {
            return false
        }
        var first = Int.max, second = Int.max
        for third in nums {
            if third <= first {
                first = third
            } else if third <= second {
                second = third
            } else if third > second {
                return true
            }
        }
        return false
    }
    
    // 335. 路径交叉
    func isSelfCrossing(_ distance: [Int]) -> Bool {
        guard distance.count > 3 else {
            return false
        }
        
        var now = 3, top = distance[2] > distance[0] ? Int.max : distance[1]
        var width = 0
        
        while now < distance.count {
            if distance[now] >= top {
                return true
            }
            if distance[now] > distance[now - 2] {
                top = Int.max
                width = distance[now - 3]
            } else if distance[now] < distance[now - 2] - width {
                top = distance[now - 1]
                width = 0
            } else {
                top = distance[now - 1] - distance[now - 3]
                width = 0
            }
            now += 1
        }
        
        return false
    }
    
    // 336. 回文对
    func palindromePairs(_ words: [String]) -> [[Int]] {

        var indices = [String: Int]()
        
        words.enumerated().forEach { (index, word) in
            indices[String(word.reversed())] = index
        }
        
        
        func isPalindrome(_ word: String) -> Bool {
            return word == String(word.reversed())
        }
        
        var ret = [[Int]]()
        for (i, word) in words.enumerated() {
            if word.isEmpty {
                indices.forEach { element in
                    if isPalindrome(element.key) && i != element.value {
                        ret.append([i, element.value])
                    }
                }
            }
            
            for index in 0..<word.count {
                let midIndex = word.index(word.startIndex, offsetBy: index)
                let firstPart = String(word[..<midIndex])
                let secondPart = String(word[midIndex...])
                
                if isPalindrome(firstPart), let j = indices[secondPart], i != j {
                    ret.append([j, i])
                }
                if isPalindrome(secondPart), let j = indices[firstPart], i != j {
                    ret.append([i, j])
                }
            }
        }
        
        return ret
    }
    
    // 337. 打家劫舍 III
    func rob(_ root: TreeNode?) -> Int {
        func robDP(_ root: TreeNode?) -> [Int] {
            guard let node = root else {
                return [0, 0]
            }
            
            let leftInfo = robDP(node.left)
            let rightInfo = robDP(node.right)
            
            // 当前节点有 2 个选择
            // 1. 偷当前节点，那么左右子节点就不能偷
            let tou = node.val + leftInfo[0] + rightInfo[0]
            // 2. 不偷当前节点，那么需要查看左右节点 是偷利益大还是不偷利益大
            let butou = max(leftInfo[1], leftInfo[0]) + max(rightInfo[0], rightInfo[1])
            return [butou, tou]
        }
        return robDP(root).max()!
    }
}
