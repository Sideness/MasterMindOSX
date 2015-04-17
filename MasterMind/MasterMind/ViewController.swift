//
//  ViewController.swift
//  MasterMind
//
//  Created by Julien Stefani on 20/03/15.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var myMaster:Master = Master()
        println(myMaster.description)
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

