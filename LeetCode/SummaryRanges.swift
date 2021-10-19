//
//  SummaryRanges.swift
//  LeetCode
//
//  Created by UED on 2021/10/18.
//

import Foundation

// 352. 将数据流变为多个不相交区间
class SummaryRanges {

    var intervals: [[Int]]
    
    init() {
        intervals = [[Int]]()
    }
    
    func addNum(_ val: Int) {
        insertNumToIntervals(val);
    }
    
    func getIntervals() -> [[Int]] {
        return intervals
    }
    
    private func insertNumToIntervals(_ num: Int) {
        // 还没有区间，则直接插入
        if intervals.isEmpty {
            intervals.append([num, num])
            return
        }
        
        // 使用二分查找确认插入位置
        var left = 0, right = intervals.count - 1
        while left <= right {
            let mid = (left + right) / 2
            let curInterval = intervals[mid]
            // 如果当前值包含于区间内，则不用进一步处理
            if curInterval[0] <= num, num <= curInterval[1] {
                return
            }
            // 如果当前值与区域某一边紧邻着，则更新对应区间
            if curInterval[0] - 1 == num {
                // num 紧邻当前区间左侧：更新左边界
                intervals[mid] = [num, curInterval[1]];
                
                // 判断是否需要进一步与左侧区间合并（num 与上一个区间右侧也紧邻着）
                if mid - 1 >= 0, intervals[mid - 1][1] == num - 1 {
                    intervals[mid] = [intervals[mid - 1][0], curInterval[1]]
                    intervals.remove(at: mid - 1)
                }
                return
            }
            if curInterval[1] + 1 == num {
                // 更新有边界
                intervals[mid] = [curInterval[0], num];
                // 判断是否需要进一步与右侧区间合并
                if mid + 1 < intervals.count, intervals[mid + 1][0] == num + 1 {
                    intervals[mid] = [curInterval[0], intervals[mid + 1][1]];
                    intervals.remove(at: mid + 1);
                }
                return;
            }
            
            // 缩小区间
            if num < curInterval[0] {
                // 当前区间较小值都比 num 大，则压缩右侧
                right = mid - 1
            } else if curInterval[1] < num {
                // 较大值都比num小，则压缩左侧
                left = mid + 1
            }
        }
        // 能执行到这里说明 num 不属于任何已有区间
        intervals.insert([num, num], at: left);
    }
}

/**
 * Your SummaryRanges object will be instantiated and called as such:
 * let obj = SummaryRanges()
 * obj.addNum(val)
 * let ret_2: [[Int]] = obj.getIntervals()
 */
