//
//  ViewController.swift
//  Attraction
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {

    
    
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear() {
        makeView(width: 1400.0, height: 900.0)
        
        let scene = Scene()
    
        present(scene: scene)
        
        tview.frameRate = 30.0
        tview.showStats = true
        
    }
    
    
    
    

}

