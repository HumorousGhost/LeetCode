//
//  ThirtySeven.swift
//  LeetCode
//
//  Created by UED on 2021/10/27.
//

import Foundation

class ThirtySeven {
    // 371. 两整数之和
    func getSum(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while b != 0 {
            let temp = (a & b) << 1
            a = a ^ b
            b = temp
        }
        return a
    }
}
