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
    var x1: Double
    var x2: Double
    var x3: Double
    var x4: Double
    
    
    init(x: Double, y: Double, w: Double, h: Double) {
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        rot = 0
        freq = random(min: 0.002, max: 0.01)
        amp = random(min: 0.0010, max: 0.01)
        child = nil
        x1 = -w / 2.0
        x2 = x1 + w
        x3 = x2 * 0.75
        x4 = x1 * 0.75
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
        
        triangle(x1: x1, y1: 0, x2: x2, y2: 0, x3: x4, y3: h)
        triangle(x1: x2, y1: 0, x2: x3, y2: h, x3: x4, y3: h)
        
        if let child = child {
            child.render()
        }
        popState()
    }
    
}
