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
        let tree = TreeNode.init(1, TreeNode.init(2, nil, TreeNode.init(5)), TreeNode.init(3, nil, TreeNode.init(4)))
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
        let result = TwentyFour().searchMatrix([[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], 5)
        print(result)
//        print(arr)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



