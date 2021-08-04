//
//  TwentySeven.swift
//  LeetCode
//
//  Created by UED on 2021/8/4.
//

import Foundation

class TwentySeven {
    // 273. 整数转换英文表示
    func numberToWords(_ num: Int) -> String {
        
        func one(_ num: Int) -> String {
            switch num {
            case 1:
                return "One"
            case 2: return "Two"
            case 3: return "Three"
            case 4: return "Four"
            case 5: return "Five"
            case 6: return "Six"
            case 7: return "Seven"
            case 8: return "Eight"
            case 9: return "Nine"
            default:
                return ""
            }
        }
        
        func twoLessThan20(_ num: Int) -> String {
            switch num {
            case 10: return "Ten"
            case 11: return "Eleven"
            case 12: return "Twelve"
            case 13: return "Thirteen"
            case 14: return "Fourteen"
            case 15: return "Fifteen"
            case 16: return "Sixteen"
            case 17: return "Seventeen"
            case 18: return "Eighteen"
            case 19: return "Nineteen"
            default:
                return ""
            }
        }
        
        func ten(_ num: Int) -> String {
            switch num {
            case 2: return "Twenty"
            case 3: return "Thirty"
            case 4: return "Forty"
            case 5: return "Fifty"
            case 6: return "Sixty"
            case 7: return "Seventy"
            case 8: return "Eighty"
            case 9: return "Ninety"
            default:
                return ""
            }
        }
        
        func two(_ num: Int) -> String {
            if num == 0 {
                return ""
            } else if num < 10 {
                return one(num)
            } else if num < 20 {
                return twoLessThan20(num)
            } else {
                let tenner = num / 10
                let rest = num - tenner * 10
                if rest != 0 {
                    return "\(ten(tenner)) \(one(rest))"
                } else {
                    return ten(tenner)
                }
            }
        }
        
        func three(_ num: Int) -> String {
            let hundred = num / 100
            let rest = num - hundred * 100
            var res = ""
            if hundred * rest != 0 {
                res = "\(one(hundred)) Hundred \(two(rest))"
            } else if hundred == 0 && rest != 0 {
                res = two(rest)
            } else if hundred != 0 && rest == 0 {
                res = one(hundred) + " Hundred"
            }
            return res
        }
        
        guard num != 0 else {
            return "Zero"
        }
        
        let billion = num / 1000000000
        let million = (num - billion * 1000000000) / 1000000
        let thousand = (num - billion * 1000000000 - million * 1000000) / 1000
        let rest = num - billion * 1000000000 - million * 1000000 - thousand * 1000
        
        var result = ""
        if billion != 0 {
            result += "\(three(billion)) Billion"
        }
        if million != 0 {
            if !result.isEmpty {
                result += " "
            }
            result += "\(three(million)) Million"
        }
        if thousand != 0 {
            if !result.isEmpty {
                result += " "
            }
            result += "\(three(thousand)) Thousand"
        }
        if rest != 0 {
            if !result.isEmpty {
                result += " "
            }
            result += three(rest)
        }
        
        return result
    }
}
