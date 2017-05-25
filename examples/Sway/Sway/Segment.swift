//
//  Segment.swift
//  Sway
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class Segment {
    var x: Double
    var y: Double
    var w: Double
    var h: Double
    var rot: Double
    var freq: Double
    var amp: Double
    var child: Segment?
    
    
    init(x: Double, y: Double, w: Double, h: Double) {
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        rot = 0.0
        freq = 0.005
        amp = 0.01
        child = nil
    }
    
    
    func add(child: Segment) {
        self.child = child
    }
    
    
    func process() {
        let u = (x + y) * freq + (Double(tin.frameCount) / 120.0)
        let z = noise(x: u, y: 0.0) * amp
        rot += z
        if let child = child {
            child.process()
        }
    }
    
    
    func render() {
        pushState()
        translate(dx: x, dy: y)
        rotate(by: rot)
        
        rect(x: -w / 2.0, y: 0.0, width: w, height: h)
        
        if let child = child {
            child.render()
        }
        popState()
    }
    
}
