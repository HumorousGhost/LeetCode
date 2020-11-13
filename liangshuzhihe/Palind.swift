//
//  Palind.swift
//  liangshuzhihe
//
//  Created by UED on 2020/11/13.
//

import Foundation

class Palind {
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false;
        }
        var rem = 0; // 个位
        var y = 0;
        var quo = x;
        while quo != 0 {
            rem = quo % 10;
            y = y * 10 + rem;
            quo = quo / 10;
        }
        return y == x;
    }
}
