//
//  CirclesView.swift
//  RandomCircles
//
//  Created by Loren Olson on 12/29/16.
//  Copyright © 2016 ASU. All rights reserved.
//

import Cocoa
import Tin


class CirclesView: TView {
    
    var needsClear = true
    

    override func setup() {
        let cgrenderer = tin.render as! CoreGraphicsRenderer
        cgrenderer.useLayer = true
        showStats = false
    }
    
    
    override func update() {
        if needsClear {
            Swift.print("clear")
            tin.background(red: 0.5, green: 0.5, blue: 0.5)
            needsClear = false
        }
        
        let x = TRandom.next(max: tin.size.width)
        let y = TRandom.next(max: tin.size.height)
        
        let r = TRandom.next(max: 1.0)
        let g = TRandom.next(max: 1.0)
        let b = TRandom.next(max: 1.0)
        
        tin.setFillColor(red: r, green: g, blue: b, alpha: 1.0)
        tin.stroke = false
        tin.ellipse(x: x, y: y, width: 60.0, height: 60.0)
        
    }
    
    
    override func keyDown(with event: NSEvent) {
        needsClear = true
        needsDisplay = true
    }
    
    
    override func mouseDown(with event: NSEvent) {
        if isRunning {
            stopUpdates()
        }
        else {
            startUpdates()
        }
    }
    
}
