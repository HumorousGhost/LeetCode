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
        let array = [10,1,2,7,6,1,5]
        let result = Four().combinationSum2(array, 8)
        print(result);
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}



