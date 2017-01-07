//
//  ViewController.swift
//  SimpleDrawing
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear() {
        
        let newFrame = NSRect(x: 0.0, y: 0.0, width: 1200.0, height: 600.0)
        
        
        if let visibleFrame = view.window?.screen?.visibleFrame {
            let newWinFrame = NSRect(x: visibleFrame.origin.x, y: visibleFrame.origin.y + visibleFrame.height - newFrame.height, width: newFrame.width, height: newFrame.height)
            view.window?.setFrame(newWinFrame, display: true)
        }
        
        view = DrawingView(frame: newFrame)
    }
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

