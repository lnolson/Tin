//
//  ViewController.swift
//  Sway
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
        super.viewWillAppear()
        
        print("1")
        makeView(width: 1200.0, height: 600.0)
        
        print("2")
        let scene = Sway()
        
        print("3")
        present(scene: scene)
        
        
        let v = view as! TView
        v.frameRate = 30.0
        v.showStats = true
    }

}

