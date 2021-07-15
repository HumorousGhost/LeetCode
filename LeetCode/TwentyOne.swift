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
}
