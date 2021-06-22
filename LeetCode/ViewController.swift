//
//  ViewController.swift
//  LeetCode
//
//  Created by UED on 2020/10/30.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var arr = [1,1,1,2,2,3]
        let list = ListNode.init(1, ListNode.init(4, ListNode.init(3, ListNode.init(2, ListNode.init(5, ListNode.init(2, ListNode.init(5, nil)))))))
        let tree = TreeNode.init(3, TreeNode.init(9), TreeNode.init(20, TreeNode.init(15), TreeNode.init(7)))
        let tree2 = TreeNode.init(2, TreeNode.init(1), TreeNode.init(3))
        let node1 = Node.init(7)
        let node2 = Node.init(13)
        let node3 = Node.init(11)
        let node4 = Node.init(10)
        let node5 = Node.init(1)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node1.random = nil
        node2.random = node1
        node3.random = node5
        node4.random = node3
        node5.random = node1
        let result = Fifteen().reverseWords("  hello world  ")
        print(result)
//        print(arr)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



