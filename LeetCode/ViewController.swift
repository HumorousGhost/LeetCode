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
        
        let result = Eleven().generate(5)
        print(result)
//        print(arr)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



