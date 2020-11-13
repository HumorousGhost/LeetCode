//
//  Match.swift
//  liangshuzhihe
//
//  Created by UED on 2020/11/13.
//

import Foundation

class Match: NSObject {
    // 正则表达式匹配
    func isMatch(_ s: String, _ p: String) -> Bool {
        if s.count > 20 || p.count > 30 {
            return false;
        }
        
        func matches(_ s1: String, _ p1: String) -> Bool {
            if p1 == "." {
                return true;
            }
            return s1 == p1;
        }
        
        let m = s.count;
        let n = p.count;
        
        var f = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1);
        f[0][0] = true;
        let sChars = s.map{String($0)};
        let pChars = p.map{String($0)};
        for i in 0..<sChars.count + 1 {
            for j in 1..<pChars.count + 1 {
                if pChars[j - 1] == "*" {
                    f[i][j] = f[i][j - 2];
                    if i != 0 && matches(sChars[i - 1], pChars[j - 2]) {
                        f[i][j] = f[i][j] || f[i - 1][j];
                    }
                } else {
                    if i != 0 && matches(sChars[i - 1], pChars[j - 1]) {
                        f[i][j] = f[i - 1][j - 1];
                    }
                }
            }
        }
        return f[m][n];
    }
    
    // 盛最多水的容器
    func maxArea(_ height: [Int]) -> Int {
        var l = 0;
        var r = height.count - 1;
        var ans = 0;
        while l < r {
            let area = min(height[l], height[r]) * (r - l);
            ans = max(ans, area);
            if height[l] <= height[r] {
                l += 1;
            } else {
                r -= 1;
            }
        }
        return ans;
    }
}
