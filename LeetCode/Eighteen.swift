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
    
    // 183. 从不订购的客户
    /**
    SELECT Customers.Name AS 'Customers'
    FROM Customers
    WHERE Customers.Id NOT IN (
        SELECT CustomerId FROM Orders
    )
    ;
     */
    
    // 184. 部门工资最高的员工
    /**
    SELECT
        Department.Name AS 'Department',
        Employee.Name AS 'Employee',
        Salary
    FROM
        Employee
            JOIN
        Department ON Employee.DepartmentId = Department.Id
    WHERE (Employee.DepartmentId, Salary) IN (
        SELECT
            DepartmentId,
            MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
    )
    ;
     */
    
    // 185. 部门工资前三高的所有员工
    /**
    SELECT
        d.Name AS 'Department',
        e1.Name AS 'Employee',
        e1.Salary
    FROM
        Employee e1
    JOIN
        Department d
    ON
        e1.DepartmentId = d.Id
    WHERE
        3 > (
            SELECT
                COUNT(DISTINCT e2.Salary)
            FROM
                Employee e2
            WHERE
                e2.Salary > e1.Salary
            AND
                e1.DepartmentId = e2.DepartmentId
        )
    ;
     */
    
    // 187. 重复的DNA序列
    func findRepeatedDnaSquences(_ s: String) -> [String] {
        let L = 10, n = s.count
        let sArr = s.map { String($0) }
        var seen = [String](), output = [String]()
        
        // iterate over all squences of length L.
        for start in stride(from: 0, to: n - L + 1, by: 1) {
            let tmp = sArr[start..<start + L].joined()
            if seen.contains(tmp) {
                if !output.contains(tmp) {
                    output.append(tmp)
                }
            }
            seen.append(tmp)
        }
        return output
    }
    
    // 188. 买卖股票的最佳时机 IV
    func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
        if prices.count == 0 || k == 0 {
            return 0
        }
        
        let n = prices.count
        let k = min(k, n / 2)
        var buy = [Int](repeating: Int.min / 2, count: k + 1)
        var sell = [Int](repeating: Int.min / 2, count: k + 1)
        buy[0] = -prices[0]
        sell[0] = 0
        
        for i in 1..<n {
            buy[0] = max(buy[0], sell[0] - prices[i])
            for j in 1...k {
                buy[j] = max(buy[j], sell[j] - prices[i])
                sell[j] = max(sell[j], buy[j - 1] + prices[i])
            }
        }
        return sell.max()!
    }
}
