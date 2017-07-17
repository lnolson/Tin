//
//  ViewController.swift
//  SimpleDrawing
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {
    
    
    override func viewDidLoad() {
        print("viewDidLoad")
    }
    
    
    override func viewWillAppear() {
        
        super.viewWillAppear()
        
        print("1")
        makeView(width: 1200.0, height: 600.0)
        
        print("2")
        let scene = Drawing()
        
        print("3")
        present(scene: scene)
    }
    


}

