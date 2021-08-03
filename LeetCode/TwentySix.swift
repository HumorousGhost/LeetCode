//
//  TwentySix.swift
//  LeetCode
//
//  Created by UED on 2021/8/2.
//

import Foundation

class TwentySix {
    // 260. 只出现一次的数字 III
    func singleNumber(_ nums: [Int]) -> [Int] {
        var ret = 0
        for n in nums {
            ret ^= n
        }
        
        var div = 1
        while (div & ret) == 0 {
            div <<= 1
        }
        
        var a = 0, b = 0
        for n in nums {
            if (div & n) != 0 {
                a ^= n
            } else {
                b ^= n
            }
        }
        
        return [a, b]
    }
    
    // 262. 行程和用户
    /**
     * SELECT
     *    Request_at AS Day,
     *    ROUND(AVG(Status != 'completed'), 2) AS 'Cancellation Rate'
     * FROM
     *    Trips t JOIN Users u1 ON (t.Client_Id = u1.Users_Id AND u1.Banned = 'No')
     * JOIN
     *    Users u2 ON (t.Driver_Id = u2.Users_Id AND u2.Banned = 'No')
     * WHERE
     *    Request_at BETWEEN '2013-10-01' AND '2013-10-03'
     * GROUP BY Request_at
     * ;
     */
    
    // 263. 丑数
    func isUgly(_ n: Int) -> Bool {
        if n <= 0 {
            return false
        }
        
        let factors = [2, 3, 5]
        var n = n
        for factor in factors {
            while n % factor == 0 {
                n /= factor
            }
        }
        
        return n == 1
    }
    
    // 264. 丑数 II
    func nthUglyNumber(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n)
        dp[0] = 1
        var p2 = 0
        var p3 = 0
        var p5 = 0
                
        for i in 1..<n {
            let v2 = dp[p2] * 2
            let v3 = dp[p3] * 3
            let v5 = dp[p5] * 5

            // 取与 2，3，5相乘最小的值放入 丑数 数组中
            let ugly = min(v2, v3, v5)
            dp[i] = ugly
                    
            // 判断 2，3，5 里已经在此次求丑数中用过的，用过则把指针前进
            if ugly == v2 {
                p2 += 1
            }
            if ugly == v3 {
                p3 += 1
            }
            if ugly == v5 {
                p5 += 1
            }
        }
        return dp[n - 1]
    }
}
