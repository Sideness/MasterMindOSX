//
//  ViewController.swift
//  MasterMind
//
//  Created by Julien Stefani on 20/03/15.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    var myMaster:Master = Master()
    var selectedColumn:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println(myMaster.toString())
        
        
        
Update()

        
     
        

    }
    
    @IBAction func validate(sender: NSButton) {
        
        myMaster.Valide()
        selectedColumn = 0
        Update()
    }
    func Update()
    {
        var customView:NSView = self.view.subviews[6] as NSView
        for var i=0; i < customView.subviews.count; i++
        {
            customView.subviews[i].removeFromSuperview()
            i--
        }
        

        for var i = 0; i < Master.NB_SUITE; i++
        {
            for var j = 0; j < Suite.NB_PION; j++
            {
                var label:NSTextField = NSTextField() as NSTextField
                label.frame = CGRectMake(CGFloat(100 * j),CGFloat(20*i), 100, 50)
                label.bezeled = false;
                label.drawsBackground = false;
                label.editable = false;
                label.selectable = false;
                label.stringValue =  myMaster.getSuite(Master.NB_SUITE-(i+1))!.getCase(j)!.toString()
                
                if (j == selectedColumn && (Master.NB_SUITE-(i+1)) == myMaster.currentIndex)
                {
                    let font = NSFont(name: "Verdana-Bold", size: 14.0)
                    
                    label.font = font
                }
                
                customView.addSubview(label)
            }
            
            var label:NSTextField = NSTextField() as NSTextField
            label.frame = CGRectMake(CGFloat(100 * Suite.NB_PION-20),CGFloat(20*i), 100, 50)
            label.bezeled = false;
            label.drawsBackground = false;
            label.editable = false;
            label.selectable = false;
            label.stringValue =  "B : " + myMaster.getSuite(Master.NB_SUITE-(i+1))!.getBlanc().description + "  |  N : " + myMaster.getSuite(Master.NB_SUITE-(i+1))!.getNoir().description
            
            
            customView.addSubview(label)

            
        }

    }

    @IBAction func columnChange(sender: NSButton) {
        selectedColumn = sender.tag
        Update()
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func colorPicker(sender: NSButton) {
        println(sender.title)
        var color:Case.Color = Case.Color(rawValue:UInt(sender.alternateTitle.toInt()!))!
        myMaster.setSelectedColor(color)
        myMaster.getSuite(myMaster.currentIndex)?.getCase(selectedColumn)?.setColor(color)
        Update()
    }
    
}

