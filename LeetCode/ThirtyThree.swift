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
}
