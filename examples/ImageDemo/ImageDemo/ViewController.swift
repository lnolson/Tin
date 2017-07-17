//
//  ViewController.swift
//  ImageDemo
//
//  Created by Loren Olson on 3/9/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {


    
    
    override func viewWillAppear() {
        
        makeView(width: 1203.0, height: 800.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        
        tin.enableRestoreFromPrevious()
    }
    
    
    
    
    

}

