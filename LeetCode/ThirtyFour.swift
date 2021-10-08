//
//  ThirtyFour.swift
//  LeetCode
//
//  Created by UED on 2021/10/8.
//

import Foundation

class ThirtyFour {
    
    // 342. 4的幂
    func isPowerOffFour(_ n: Int) -> Bool {
        
        return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1
    }
}
