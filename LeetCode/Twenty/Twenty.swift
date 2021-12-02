//
//  Twenty.swift
//  LeetCode
//
//  Created by UED on 2021/7/12.
//

import Foundation

class Twenty {
    // 200. 岛屿数量
    func numIslands(_ grid: [[Character]]) -> Int {
        var grid = grid
        func dfs(_ r: Int, _ c: Int) {
            let nr = grid.count
            let nc = grid[0].count
            
            if r < 0 || c < 0 || r >= nr || c >= nc || grid[r][c] == "0" {
                return
            }
            
            grid[r][c] = "0"
            dfs(r - 1, c)
            dfs(r + 1, c)
            dfs(r, c - 1)
            dfs(r, c + 1)
        }
        
        if grid.count == 0 {
            return 0
        }
        
        let nr = grid.count, nc = grid[0].count
        var numIslands = 0
        for r in 0..<nr {
            for c in 0..<nc {
                if grid[r][c] == "1" {
                    numIslands += 1
                    dfs(r, c)
                }
            }
        }
        
        return numIslands
    }
    
    // 201. 数字范围按位与
    func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
        var shift = 0, left = left, right = right
        // 找到公共前缀
        while left < right {
            left >>= 1
            right >>= 1
            shift += 1
        }
        return left << shift
    }
    
    // 202. 快乐数
    func isHappy(_ n: Int) -> Bool {
        
        func getNext(_ n: Int) -> Int {
            var totalSum = 0, n = n
            while n > 0 {
                let d = n % 10
                n = n / 10
                totalSum += d * d
            }
            return totalSum
        }
        
        var seen = [Int](), n = n
        while n != 1 && !seen.contains(n) {
            seen.append(n)
            n = getNext(n)
        }
        
        return n == 1
    }
    
    
    // 203. 移除链表元素
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        
        let newHead = ListNode.init(0, head)
        var temp: ListNode? = newHead
        
        while temp?.next != nil {
            
            if temp!.next!.val == val {
                temp?.next = temp?.next?.next
            } else {
                temp = temp?.next
            }
        }
        
        return newHead.next
    }
    
    // 204. 计数质数
    func countPrimes(_ n: Int) -> Int {
        
        func isPrimes(_ x: Int) -> Bool {
            var i = 2
            while i * i <= x {
                if x % i == 0 {
                    return false
                }
                i += 1
            }
            return true
        }
        
        if n <= 2 {
            return 0
        }
        
        var ans = 0
        for i in 2..<n {
            ans += isPrimes(i) ? 1 : 0
        }
        
        return ans
    }
    
    // 205. 同构字符串
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        let sArr = s.map({ String($0) }), tArr = t.map({ String($0) })
        
        var s2t = [String: String]()
        var t2s = [String: String]()
        let count = s.count
        for i in 0..<count {
            let x = sArr[i], y = tArr[i]
            if (s2t[x] != nil && s2t[x] != y) || (t2s[y] != nil && t2s[y] != x) {
                return false
            }
            s2t[x] = y
            t2s[y] = x
        }
        return true
    }
    
    // 206. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var curr = head
        while curr != nil {
            let next = curr?.next
            curr?.next = prev
            prev = curr
            curr = next
        }
        return prev
    }
    
    // 207. 课程表
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var edges = [[Int]](repeating: [Int](repeating: 0, count: 0), count: numCourses)
        for info in prerequisites {
            edges[info[1]].append(info[0])
        }
        
        var visited = [Int](repeating: 0, count: numCourses)
        var valid = true
        
        func dfs(_ u: Int) {
            visited[u] = 1
            for v in edges[u] {
                if visited[v] == 0 {
                    dfs(v)
                    if !valid {
                        return
                    }
                } else if visited[v] == 1 {
                    valid = false
                    return
                }
            }
            visited[u] = 2
        }
        
        var i = 0
        while i < numCourses && valid {
            if visited[i] == 0 {
                dfs(i)
            }
            i += 1
        }
        
        return valid
    }
    
    // 209. 长度最小的子数组
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var lengths = [Int]()
        let count = nums.count
        for i in 0..<count {
            let num = nums[i]
            var sum = target - num
            if sum <= 0 {
                return 1
            }
            var length = 1
            for j in i + 1..<count {
                if sum - nums[j] <= 0 {
                    length += 1
                    lengths.append(length)
                    break
                } else {
                    sum -= nums[j]
                    length += 1
                }
            }
        }
        return lengths.min() ?? 0
    }
}
