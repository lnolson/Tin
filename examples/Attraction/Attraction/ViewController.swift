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

    var movers: [Mover] = []
    
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear() {
        createView(width: 1400.0, height: 900.0)
        
        for _ in 0...210 {
            let x = TRandom.next(max: Double(view.frame.width))
            let y = TRandom.next(max: Double(view.frame.height))
            debug(" mover \(x),\(y)")
            let mover = Mover(x: x, y: y)
            movers.append(mover)
        }
        
        let v = view as! TView
        v.frameRate = 60.0
        v.showStats = true
    }
    
    
    
    override func update() {
        
        background(red: 0.5, green: 0.5, blue: 0.5)
        strokeColor(red: 0.01, green: 0.01, blue: 0.01, alpha: 1.0)
        fillColor(red: 0.7, green: 0.2, blue: 0.1, alpha: 1.0)
        lineWidth(1.0)
        for m1 in movers {
            for m2 in movers {
                if m1 !== m2 {
                    let force = m2.attract( m: m1 );
                    m1.applyForce( force: force );
                }
            }
            m1.update()
            m1.render()
        }
    }

}

