//
//  ViewController.swift
//  LeetCode
//
//  Created by UED on 2020/10/30.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var arr = ["eat", "tea", "tan", "ate", "nat", "bat"]
        let result = Five().totalNQueens(4)
        print(result)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



