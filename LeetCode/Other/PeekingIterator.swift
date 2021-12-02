//
//  PeekingIterator.swift
//  LeetCode
//
//  Created by UED on 2021/8/6.
//

import Foundation

// 284. 顶端迭代器

// Swift IndexingIterator refernence:
// https://developer.apple.com/documentation/swift/indexingiterator

class PeekingIterator {
    
    var array: [Int]
    var nextNum: Int
    var peekNum: Int
    var length: Int
    init(_ arr: IndexingIterator<Array<Int>>) {
        self.array = [Int](arr)
        self.nextNum = 0
        self.peekNum = 0
        self.length = arr.underestimatedCount
    }
    
    func next() -> Int {
        let num = self.array[nextNum]
        nextNum += 1
        peekNum = nextNum
        return num
    }
    
    func peek() -> Int {
        let num = self.array[peekNum]
        return num
    }
    
    func hasNext() -> Bool {
        return nextNum == length - 1
    }
}

/**
 * Your PeekingIterator object will be instantiated and called as such:
 * let obj = PeekingIterator(arr)
 * let ret_1: Int = obj.next()
 * let ret_2: Int = obj.peek()
 * let ret_3: Bool = obj.hasNext()
 */
