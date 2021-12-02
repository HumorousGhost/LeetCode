//
//  Codec.swift
//  LeetCode
//
//  Created by UED on 2021/8/10.
//

import Foundation
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *      public var val: Int
 *      public var left: TreeNode?
 *      public var right: TreeNode?
 *      public init(_ val: Int) {
 *          self.val = val
 *          self.left = nil
 *          self.right = nil
 *      }
 * }
 */

// 297. 二叉树的序列化与反序列化
class Codec {
    func serialize(_ root: TreeNode?) -> String {
        var rootString = ""
        
        func treeToString(_ root: TreeNode?) {
            if root == nil {
                rootString.append("null,")
                return
            }
            rootString.append("\(root!.val.description),")
            treeToString(root?.left)
            treeToString(root?.right)
        }
        
        treeToString(root)
        rootString.removeLast()
        return rootString
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        if data.isEmpty {
            return nil
        }
        
        var index = 0
        
        func stringToTree(_ items: [String]) -> TreeNode? {
            if items[index] == "null" {
                index += 1
                return nil
            }
            let node = TreeNode.init(Int(items[index])!)
            index += 1
            node.left = stringToTree(items)
            node.right = stringToTree(items)
            return node
        }
        
        let items = data.components(separatedBy: ",")
        return stringToTree(items)
    }
}

/**
 * Your Codec object will be instantiated and called as such:
 * var ser = Codec()
 * var deser = Codec()
 * deser.deserialize(ser.serialize(root))
 */
