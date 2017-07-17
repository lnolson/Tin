//
//  ViewController.swift
//  CartDemo
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {

    var scene = Scene()
    

    override func viewWillAppear() {
        makeView(width: 1400.0, height: 600.0)
        
        present(scene: scene)
        
    }
    
    
        
    
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        scene.moveCart(dx: (tin.mouseX - tin.pmouseX))
    }

}

