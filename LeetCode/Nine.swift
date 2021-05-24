//
//  Nine.swift
//  LeetCode
//
//  Created by UED on 2021/5/21.
//

import Cocoa

class Nine: NSObject {
    // 90. 子集 II
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var t = [Int](repeating: 0, count: 0)
        var ans = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        
        func dfs(_ choosePre: Bool, _ cur: Int, _ nums: [Int]) {
            if cur == nums.count {
                ans.append(t)
                return
            }
            dfs(false, cur + 1, nums)
            if !choosePre && cur > 0 && nums[cur - 1] == nums[cur] {
                return
            }
            t.append(nums[cur])
            dfs(true, cur + 1, nums)
            t.removeLast()
        }
        
        let sortNums = nums.sorted()
        dfs(false, 0, sortNums)
        return ans
    }
}
