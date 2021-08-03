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
}
