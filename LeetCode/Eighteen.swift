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
}
