//
//  ViewController.swift
//  RandomCircles
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {
    
    
    var scene = Scene()
    

    override func viewWillAppear() {
        
        super.viewWillAppear()
        
        makeView(width: 800.0, height: 800.0)
        
        present(scene: scene)
        
        let v = view as! TView
        v.showStats = false
    }


    override func viewDidAppear() {
        tin.enableRestoreFromPrevious()
    }
    
    

    override func keyDown(with event: NSEvent) {
        scene.needsClear = true
        view.needsDisplay = true
    }
    
    
    override func mouseDown(with event: NSEvent) {
        let tview = view as! TView
        if tview.isRunning {
            tview.stopUpdates()
        }
        else {
            tview.startUpdates()
        }
    }
    

}

