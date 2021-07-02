//
//  Eighteen.swift
//  LeetCode
//
//  Created by UED on 2021/7/1.
//

import Foundation

class Eighteen {
    // 180. 连续出现的数字
    /**
     SELECT DISTINCT
        l1.Num AS ConsecutiveNums
     FROM
        Logs l1,
        Logs l2,
        Logs l3
     WHERE
        l1.Id = l2.Id - 1
        AND l2.Id = l3.Id - 1
        AND l1.Num = l2.Num
        AND l2.Num = l3.Num
     ;
     */
    
    // 181. 超过经理收入的员工
    /**
    SELECT
        a.Name AS Employee
    FROM Employee AS a JOIN Employee AS b
        ON a.ManagerId = b.Id
        AND a.Salary > b.Salary
    ;
     */
    
    // 182. 查找重复的电子邮箱
    /**
    SELECT
        Email
    FROM Person
        GROUP BY Email
        HAVING COUNT(Email) > 1
    ;
     */
}
