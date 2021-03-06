//
//  Scene.swift
//  CartDemo
//
//  Created by Loren Olson on 7/17/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin



class Scene: TScene {
    
    var x = 400.0
    var y = 200.0
    var w = 100.0
    var r = 40.0
    let bodyWidth = 200.0
    let bodyHeight = 70.0
    
    
    override func setup() {
        if let view = view {
            w = Double(view.frame.width)
        }
    }
    
    
    override func update() {
        background(red: 0.5, green: 0.5, blue: 0.5)
        
        // Ground
        fillColor(red: 0.05, green: 0.4, blue: 0.1, alpha: 1.0)
        strokeDisable()
        rect(x: 0, y: 0, width: w, height: y-r)
        
        cart()
    }
    
    
    func cart() {
        pushState()
        translate(dx: x, dy: y)
        
        // draw the body of the Cart
        fillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lineWidth(3.0)
        strokeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        rect(x: -(bodyWidth/2.0), y: 0.0, width: bodyWidth, height: bodyHeight)
        
        // Two wheels
        let wheelBase = (bodyWidth / 2.0) * 0.55
        wheel(wx: -wheelBase)
        wheel(wx:  wheelBase)
        
        popState()
    }
    
    
    func wheel(wx: Double) {
        pushState()
        translate(dx: wx, dy: 0.0)
        let a = -x / r
        Tin.rotate(by: a)
        
        
        //ellipse(x: -r, y: -r, width: r * 2, height: r * 2)
        ellipse(centerX: 0.0, centerY: 0.0, width: r * 2.0, height: r * 2.0)
        
        // Draw two lines, so we can see wheel rotation
        line(x1: 0.0, y1: -r, x2: 0.0, y2: r)
        line(x1: -r, y1: 0.0, x2: r, y2: 0.0)
        
        popState()
    }
    
    
    func moveCart(dx: Double) {
        x += dx
    }

    
}
