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
        var arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let result = Five().spiralOrder(arr)
        print(result)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



