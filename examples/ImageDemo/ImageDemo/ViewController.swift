//
//  ViewController.swift
//  ImageDemo
//
//  Created by Loren Olson on 3/9/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear() {
        
        let newFrame = NSRect(x: 0.0, y: 0.0, width: 1203.0, height: 800.0)
        
        
        if let visibleFrame = view.window?.screen?.visibleFrame {
            let newWinFrame = NSRect(x: visibleFrame.origin.x, y: visibleFrame.origin.y + visibleFrame.height - newFrame.height, width: newFrame.width, height: newFrame.height)
            view.window?.setFrame(newWinFrame, display: true)
        }
        
        view = DemoView(width: 1203.0, height: 800.0)
        
    }
    

}

