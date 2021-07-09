//
//  Nineteen.swift
//  LeetCode
//
//  Created by UED on 2021/7/6.
//

import Foundation

class Nineteen {
    // 190. 颠倒二进制位
    func reverseBits(_ n: Int) -> Int {
        var rev = 0, n = n
        var i = 0
        while i < 32 && n > 0 {
            rev |= (n & 1) << (31 - i)
            n >>= 1
            i += 1
        }
        return rev
    }
    
    // 191. 位1的个数
    func hammingWeight(_ n: Int) -> Int {
        var ret = 0, n = n
        while n > 0 {
            n &= n - 1
            ret += 1
        }
        return ret
    }
    
    // 192. 统计词频
    /**
     cat words.txt |tr -s ' ' '\n' |sort|uniq -c|sort -r|awk '{print $2,$1}'
     */
    
    // 193. 有效电话号码
    /**
     awk '/^([0-9]{3}-|\([0-9]{3}\) )[0-9]{3}-[0-9]{4}$/' file.txt
     */
    
    // 194. 转置文件
    /**
     # 获取第一行，然后用wc来获取列数
     COLS=`head -1 file.txt | wc -w`
     # 使用awk依次去输出文件的每一列的参数，然后用xargs做转置
     for (( i = 1; i <= $COLS; i++ )); do
         # 这里col就是在代码里要替换的参数，而它等于$i
         awk -v col=$i '{print $col}' file.txt | xargs
     done
     */
    
    // 195. 第十行
    /**
     sed -n "10p" file.txt
     */
    
    // 196. 删除重复的电子邮箱
    /**
    DELETE p1
    FROM Person p1,
        Person p2
    WHERE
        p1.Email = p2.Email
    AND p1.Id > p2.Id
    ;
     */
    
    // 197. 上升的温度
    /**
    SELECT
        weather.Id AS 'Id'
    FROM
        Weather
    JOIN
        weather w ON DATEDIFF(weather.RecordDate, w.RecordDate) = 1
    AND
        weather.Temperature > w.Temperature
    ;
     */
    
    // 198. 打家劫舍
    func rob(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        let count = nums.count
        if count == 1 {
            return nums[0]
        }
        
        var first = nums[0], second = max(nums[0], nums[1])
        if count == 2 {
            return second
        }
        for i in 2..<count {
            let temp = second
            second = max(first + nums[i], second)
            first = temp
        }
        return second
    }
}
