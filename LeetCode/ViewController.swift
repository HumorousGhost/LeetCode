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
        let m = "2"
        let n = "3"
        let result = Four().mutiply(m, n)
        print(result)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



