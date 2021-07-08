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
}
