//
//  Thirteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/10.
//

import Cocoa

class Thirteen: NSObject {
    // 130. 被围绕的区域
    func solve(_ board: inout [[Character]]) {
        let n = board.count
        if n == 0 {
            return
        }
        let m = board[0].count
        if m <= 1 {
            return
        }
        
        func dfs(_ x: Int, _ y: Int) {
            if x < 0 || x >= n || y < 0 || y >= m || board[x][y] != "O" {
                return
            }
            board[x][y] = "A"
            dfs(x + 1, y)
            dfs(x - 1, y)
            dfs(x, y + 1)
            dfs(x, y - 1)
        }
        
        for i in 0..<n {
            dfs(i, 0)
            dfs(i, m - 1)
        }
        for i in 1..<m - 1 {
            dfs(0, i)
            dfs(n - 1, i)
        }
        
        for i in 0..<n {
            for j in 0..<m {
                if board[i][j] == "A" {
                    board[i][j] = "O"
                } else if (board[i][j] == "O") {
                    board[i][j] = "X"
                }
            }
        }
    }
    
    // 131. 分割回文串
    func partition(_ s: String) -> [[String]] {
        let n = s.count
        let sArr = s.map { String($0) }
        var f = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        var ret = [[String]]()
        var ans = [String]()
        
        // 记忆化搜索中，f[i][j] = 0 表示未搜索，1 表示是回文串，-1 表示不是回文串
        func isPalindrome(_ i: Int, _ j: Int) -> Int {
            if f[i][j] != 0 {
                return f[i][j]
            }
            
            if i >= j {
                f[i][j] = 1
            } else if sArr[i] == sArr[j] {
                f[i][j] = isPalindrome(i + 1, j - 1)
            } else {
                f[i][j] = -1
            }
            return f[i][j]
        }
        
        func dfs(_ i: Int) {
            if i == n {
                ret.append(ans)
                return
            }
            for j in i..<n {
                if isPalindrome(i, j) == 1 {
                    ans.append((sArr[i..<j + 1]).joined())
                    dfs(j + 1)
                    ans.removeLast()
                }
            }
        }
        
        dfs(0)
        
        return ret
    }
    
    // 132. 分割回文串 II
    func minCut(_ s: String) -> Int {
        let n = s.count
        let sArr = s.map { String($0) }
        var f = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        var result = Int.max
        var ans = [String]()
        
        // 记忆化搜索中，f[i][j] = 0 表示未搜索，1 表示是回文串，-1 表示不是回文串
        func isPalindrome(_ i: Int, _ j: Int) -> Int {
            if f[i][j] != 0 {
                return f[i][j]
            }
            
            if i >= j {
                f[i][j] = 1
            } else if sArr[i] == sArr[j] {
                f[i][j] = isPalindrome(i + 1, j - 1)
            } else {
                f[i][j] = -1
            }
            return f[i][j]
        }
        
        func dfs(_ i: Int) {
            if i == n {
                result = min(ans.count, result)
                return
            }
            for j in i..<n {
                if isPalindrome(i, j) == 1 {
                    ans.append((sArr[i..<j + 1]).joined())
                    dfs(j + 1)
                    ans.removeLast()
                }
            }
        }
        
        dfs(0)
        
        return result - 1
    }
    
    // 133. 克隆图
    var visited = [Int: Node?]()
    func cloneGraph(_ node: Node?) -> Node? {
        if node == nil {
            return node
        }
        
        // 如果该节点已经被访问过了，则直接从哈希表中取出对应的克隆节点返回
        if visited.keys.contains(node!.val) {
            return visited[node!.val]!
        }
        
        // 克隆节点，注意到为了深拷贝，我们不会克隆它的邻居的列表
        let cloneNode = Node.init(node!.val)
        // 哈希表存储
        visited[node!.val] = cloneNode
        
        // 遍历该节点的邻居并更新克隆节点的邻居列表
        for neighbor in node!.neighbors {
            cloneNode.neighbors.append(cloneGraph(neighbor))
        }
        
        return cloneNode
    }
    
    // 134. 加油站
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) ->Int {
        let n = gas.count
        var i = 0
        while i < n {
            var sumOfGas = 0, sumOfCost = 0
            var cnt = 0
            while cnt < n {
                let j = (i + cnt) % n
                sumOfGas += gas[j]
                sumOfCost += cost[j]
                if sumOfCost > sumOfGas {
                    break
                }
                cnt += 1
            }
            if cnt == n {
                return i
            } else {
                i = i + cnt + 1
            }
        }
        return -1
    }
    
    // 135. 分发糖果
    func candy(_ ratings: [Int]) -> Int {
        let n = ratings.count
        var ret = 1
        var inc = 1, dec = 0, pre = 1
        for i in 1..<n {
            if ratings[i] >= ratings[i - 1] {
                dec = 0
                pre = ratings[i] == ratings[i - 1] ? 1 : pre + 1
                ret += pre
                inc = pre
            } else {
                dec += 1
                if dec == inc {
                    dec += 1
                }
                ret += dec
                pre = 1
            }
        }
        return ret
    }
    
    // 136. 只出现一次的数字
    func singleNumber(_ nums: [Int]) -> Int {
        var single = 0
        for num in nums {
            single ^= num
        }
        return single
    }
    
    // 137. 只出现一次的数字
    func singleNumber2(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
        for num in nums {
            map[num] = map[num] != nil ? map[num]! + 1 : 1
        }
        
        for (key, value) in map {
            if value == 1 {
                return key
            }
        }
        return 0
    }
}
