//
//  Twelve.swift
//  LeetCode
//
//  Created by UED on 2021/6/4.
//

import Cocoa

class Twelve: NSObject {
    // 120. 三角形最小路径和
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        var f = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        f[0][0] = triangle[0][0]
        for i in 1..<n {
            f[i][0] = f[i - 1][0] + triangle[i][0]
            for j in 1..<i {
                f[i][j] = min(f[i - 1][j - 1], f[i - 1][j]) + triangle[i][j]
            }
            f[i][i] = f[i - 1][i - 1] + triangle[i][i]
        }
        var minTotal = f[n - 1][0]
        for i in 1..<n {
            minTotal = min(minTotal, f[n - 1][i])
        }
        return minTotal
    }
    
    // 121. 买卖股票的最佳时机
    func maxProfit(_ prices: [Int]) -> Int {
        var price = 0
        var minPrice = Int.max
        for i in 0..<prices.count {
            if prices[i] < minPrice {
                minPrice = prices[i]
            } else if prices[i] - minPrice > price {
                price = prices[i] - minPrice
            }
        }
        return price
    }
    
    // 122. 买卖股票的最佳时机 II
    func maxProfit2(_ prices: [Int]) -> Int {
        var ans = 0
        let n = prices.count
        for i in 1..<n {
            ans += max(0, prices[i] - prices[i - 1])
        }
        return ans
    }
    
    // 123. 买卖股票的最佳时机 III
    func maxProfit3(_ prices: [Int]) -> Int {
        let n = prices.count
        var buy1 = -prices[0], sell1 = 0
        var buy2 = -prices[0], sell2 = 0
        for i in 1..<n {
            buy1 = max(buy1, -prices[i])
            sell1 = max(sell1, buy1 + prices[i])
            buy2 = max(buy2, sell1 - prices[i])
            sell2 = max(sell2, buy2 + prices[i])
        }
        return sell2
    }
    
    // 124. 二叉树中最大路径和
    func maxPathSum(_ root: TreeNode?) -> Int {
        var maxSum = Int.min
        
        func maxGain(_ node: TreeNode?) -> Int {
            if node == nil {
                return 0
            }
            
            // 递归计算左右子节点的最大贡献值
            // 只有在最大贡献值大于 0 时，才会选取对应子节点
            let leftGain = max(maxGain(node?.left), 0)
            let rightGain = max(maxGain(node?.right), 0)
            
            // 节点的最大路径和取决于该节点的值与节点的左右子节点的最大贡献值
            let priceNewpath = node!.val + leftGain + rightGain
            
            // 更新答案
            maxSum = max(maxSum, priceNewpath)
            
            // 返回节点的最大贡献值
            return node!.val + max(leftGain, rightGain)
        }
        
        _ = maxGain(root)
        
        return maxSum
    }
    
    // 125. 验证回文串
    func isPalidrome(_ s: String) -> Bool {
        let str = s.lowercased()
        let sArr = str.map { String($0) }
        
        let letter = "a"..."z"
        let number = "0"..."9"
        
        var left = 0, right = sArr.count - 1
        while left <= right {
            let leftStr = sArr[left]
            let rightStr = sArr[right]
            if !letter.contains(leftStr) && !number.contains(leftStr) {
                left += 1
            } else if !letter.contains(rightStr) && !number.contains(rightStr) {
                right -= 1
            } else if leftStr == rightStr {
                left += 1
                right -= 1
            } else {
                return false
            }
        }
        return true
    }
    
    // 126. 单词接龙 II
    func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
        var ans = [[String]]()
        if !wordList.contains(endWord) {
            return ans
        }
        
        // direction 为 true 代表向下扩展，false 代表向上扩展
        func bfsHelper(_ set1: [String], _ set2: [String], _ wordSet: [String], _ direction: Bool, _ map: [String: [String]]) -> Bool {
            // set1 为空了，就直接结束
            // 比如下边的例子就会造成 set1 为空
            /**
             "hot"
             "dog"
             ["hot", "dog"]
             */
            if set1.isEmpty {
                return false
            }
            // set1 的数量多，就反向扩展
            if set1.count > set2.count {
                return bfsHelper(set2, set1, wordSet, !direction, map)
            }
            let wordSet = NSMutableArray.init(array: wordSet)
            wordSet.removeObjects(in: set1)
            wordSet.removeObjects(in: set2)
            
            var done = false
            
            // 保存新扩展得到的节点
            var set = [String]()
            
            for str in set1 {
                // 遍历每一位
                for (index, value) in str.enumerated() {
                    
                }
            }
            
            return false
        }
        
        // 利用递归实现双向搜索
        func bfs(_ beginWord: String, _ endWord: String, _ wordList: [String], _ map: [String: [String]]) {
            var arr1 = [String]()
            arr1.append(beginWord)
            var arr2 = [String]()
            arr2.append(endWord)
        }
        
        
        // 利用 BFS 得到所有的邻居节点
        var map = [String: [String]]()
        
        
        return ans
    }
    
    // 127. 单词接龙
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        
        var wordId = [String: Int]()
        var edge = [[Int]](repeating: [Int](repeating: 0, count: 0), count: wordList.count)
        var  nodeNum = 0
        
        func addWord(_ word: String) {
            if !wordId.keys.contains(word) {
                nodeNum += 1
                wordId[word] = nodeNum
                edge.append([Int](repeating: 0, count: 0))
            }
        }
        
        func addEdge(_ word: String) {
            addWord(word)
            let id1 = wordId[word]!
            var array = word.map { String($0) }
            for i in 0..<array.count {
                let tmp = array[i]
                array[i] = "*"
                let newWord = array.joined()
                addWord(newWord)
                let id2 = wordId[newWord]!
                edge[id1].append(id2)
                edge[id2].append(id1)
                array[i] = tmp
            }
        }
        
        for word in wordList {
            addEdge(word)
        }
        addEdge(beginWord)
        if !wordId.keys.contains(endWord) {
            return 0
        }
        
        var disBegin = [Int](repeating: Int.max, count: nodeNum + 1)
        let beginId = wordId[beginWord]!
        disBegin[beginId] = 0
        var queBegin = [Int]()
        queBegin.append(beginId)
        
        var disEnd = [Int](repeating: Int.max, count: nodeNum + 1)
        let endId = wordId[endWord]!
        disEnd[endId] = 0
        var queEnd = [Int]()
        queEnd.append(endId)
        
        while !queBegin.isEmpty && !queEnd.isEmpty {
            let queBeginSize = queBegin.count
            for _ in 0..<queBeginSize {
                let nodeBegin = queBegin.removeFirst()
                if disEnd[nodeBegin] != Int.max {
                    return (disBegin[nodeBegin] + disEnd[nodeBegin]) / 2 + 1
                }
                let arr = edge[nodeBegin] as [Int]
                for it in arr {
                    if disBegin[it] == Int.max {
                        disBegin[it] = disBegin[nodeBegin] + 1
                        queBegin.append(it)
                    }
                }
            }
            
            let queEndSize = queEnd.count
            for _ in 0..<queEndSize {
                let nodeEnd = queEnd.removeFirst()
                if disBegin[nodeEnd] != Int.max {
                    return (disBegin[nodeEnd] + disEnd[nodeEnd]) / 2 + 1
                }
                let arr = edge[nodeEnd] as [Int]
                for it in arr {
                    if disEnd[it] == Int.max {
                        disEnd[it] = disEnd[nodeEnd] + 1
                        queEnd.append(it)
                    }
                }
            }
        }
        
        return 0
    }
    
    // 128. 最长连续序列
    func longestConsecutive(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        var map = [Int: Int]()
        for num in nums {
            map[num] = num
        }
        let dictKeys = [Int](map.keys)
        let nums = dictKeys.sorted()
        var length = 0
        var currentLength = 1
        for i in 0..<nums.count - 1 {
            if nums[i] + 1 == nums[i + 1] {
                currentLength += 1
            } else {
                length = max(length, currentLength)
                currentLength = 1
            }
        }
        length = max(length, currentLength)
        return length
    }
    
    // 129. 求跟节点到叶节点数字之和
    func sumNumbers(_ root: TreeNode?) -> Int {
        
        func dfs(_ root: TreeNode?, _ prevSum: Int) -> Int {
            if root == nil {
                return 0
            }
            let sum = prevSum * 10 + root!.val
            if root?.left == nil && root?.right == nil {
                return sum
            } else {
                return dfs(root?.left, sum) + dfs(root?.right, sum)
            }
        }
        
        return dfs(root, 0)
    }
}
