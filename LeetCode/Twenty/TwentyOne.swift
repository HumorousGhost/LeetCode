//
//  TwentyOne.swift
//  LeetCode
//
//  Created by UED on 2021/7/15.
//

import Foundation

class TwentyOne {
    // 210. 课程表 II
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        // 存储有向图
        var edges = [[Int]](repeating: [Int](repeating: 0, count: 0), count: numCourses)
        // 标记每个节点的状态：0-未搜索，1-搜索中，2-已完成
        var visited = [Int](repeating: 0, count: numCourses)
        // 用数组来模拟栈，下标 n - 1 为栈底，0 为栈顶
        var result = [Int](repeating: 0, count: numCourses)
        // 判断有向图中是否有环
        var valid = true
        // 栈下标
        var index = numCourses - 1
        for info in prerequisites {
            edges[info[1]].append(info[0])
        }
        
        func dfs(_ u: Int) {
            // 将节点标记为 搜索中
            visited[u] = 1
            // 搜索其相邻节点
            // 只要发现有环，立刻停止搜索
            for v in edges[u] {
                // 如果 未搜索 那么搜索相邻节点
                if visited[v] == 0 {
                    dfs(v)
                    if !valid {
                        return
                    }
                }
                // 如果 搜索中 说明找到了环
                else if visited[v] == 1 {
                    valid = false
                    return
                }
            }
            // 将节点标记为 已完成
            visited[u] = 2
            // 将节点入栈
            result[index] = u
            index -= 1
        }
        
        // 每次挑选一个 未搜索 的节点，开始进行深度优先搜索
        var i = 0
        while i < numCourses && valid {
            if visited[i] == 0 {
                dfs(i)
            }
            i += 1
        }
        
        if !valid {
            return []
        }
        // 如果没有环，那么就有拓扑排序
        return result
    }
    
    // 212. 单词搜索 II
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        
        class TrieNode {
            var children: [Character: TrieNode]
            var word: String?
            init() {
                children = [Character: TrieNode]()
                word = nil
            }
        }
        
        var board = board
        var result = [String]()
        
        func buildTrie(_ words: [String]) -> TrieNode {
            let root = TrieNode()
            for word in words {
                var node = root
                for char in word {
                    if node.children[char] == nil {
                        node.children[char] = TrieNode()
                    }
                    node = node.children[char]!
                }
                node.word = word
            }
            return root
        }
        
        func backtrack(_ i: Int, _ j: Int, _ parent: TrieNode) {
            guard i >= 0 && j >= 0 && i < board.count && j < board[0].count else {
                return
            }
            
            let char = board[i][j]
            guard let currNode = parent.children[char] else {
                return
            }
            
            if let word = currNode.word {
                result.append(word)
                currNode.word = nil
            }
            
            board[i][j] = "#"
            backtrack(i + 1, j, currNode)
            backtrack(i - 1, j, currNode)
            backtrack(i, j + 1, currNode)
            backtrack(i, j - 1, currNode)
            board[i][j] = char
            
            if currNode.children.isEmpty {
                parent.children[char] = nil
            }
        }
        
        let root = buildTrie(words)
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                backtrack(i, j, root)
            }
        }
        return result
    }
    
    // 213. 打家劫舍 II
    func rob(_ nums: [Int]) -> Int {
        
        func robRange(_ start: Int, _ end: Int) -> Int {
            var first = nums[start], second = max(nums[start], nums[start + 1])
            for i in start + 2...end {
                let temp = second
                second = max(first + nums[i], second)
                first = temp
            }
            return second
        }
        
        let count = nums.count
        if count == 0 {
            return 0
        } else if count == 1 {
            return nums[0]
        } else if count == 2 {
            return max(nums[0], nums[1])
        } else if count == 3 {
            return max(nums[0], max(nums[1], nums[2]))
        } else {
            return max(robRange(0, count - 2), robRange(1, count - 1))
        }
    }
    
    // 214. 最短回文串
    func shortestPalindrome(_ s: String) -> String {
        if s.count < 1 {
            return ""
        }
        
        let array = s.map{$0}
        var index = 0
        for i in (0..<s.count).reversed() {
            var a = 0
            var b = i
            while a <= b {
                if array[a] == array[b] {
                    a += 1
                    b -= 1
                } else {
                    break
                }
            }
            if a >= b {
                index = i
                break
            }
        }
        
        var result = s
        for i in index + 1..<s.count {
            result.insert(array[i], at: result.startIndex)
        }
        return result
    }
    
    // 215. 数组中的第K个最大元素
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let array = nums.sorted()
        if k > array.count {
            return 0
        } else {
            return array[array.count - k]
        }
    }
    
    // 216. 组合总和 III
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var temp = [Int]()
        var ans = [[Int]]()
        
        func check(_ mask: Int) -> Bool {
            temp.removeAll()
            for i in 0..<9 {
                if ((1 << i) & mask) != 0 {
                    temp.append(i + 1)
                }
            }
            if temp.count != k {
                return false
            }
            var sum = 0
            for num in temp {
                sum += num
            }
            return sum == n
        }
        
        for mask in 0..<(1 << 9) {
            if check(mask) {
                ans.append(temp)
            }
        }
        return ans
    }
    
    // 217. 存在重复元素
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var map = [Int: Int]()
        for num in nums {
            if let _ = map[num] {
                return true
            } else {
                map[num, default: 0] += 1
            }
        }
        return false
    }
    
    // 218. 天际线问题
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        
        var points = [Int]()
        for building in buildings {
            points.append(building[0])
            points.append(building[1])
        }
        points.sort()
        var pointsHigh = [Int](repeating: 0, count: points.count)
        var pos = 0
        for building in buildings {
            while points[pos] < building[0] {
                pos += 1
            }
            var i = pos
            while points[i] < building[1] {
                if pointsHigh[i] < building[2] {
                    pointsHigh[i] = building[2]
                }
                i += 1
            }
        }
        
        var res = [[Int]]()
        var currentHigh = 0
        for i in 0..<pointsHigh.count {
            let high = pointsHigh[i]
            if high != currentHigh {
                res.append([points[i], high])
                currentHigh = high
            }
            
        }
        
        return res
    }
    
    // 219. 存在重复元素 II
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var map = [Int: Int]()
        for i in 0..<nums.count {
            let num = nums[i]
            if let value = map[num] {
                if i - value <= k {
                    return true
                }
            }
            map[num] = i
        }
        return false
    }
}
