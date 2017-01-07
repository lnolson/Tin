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
    var x: CGFloat
    var y: CGFloat
    var w: CGFloat
    var h: CGFloat
    var rot: CGFloat
    var freq: CGFloat
    var amp: CGFloat
    var child: Segment?
    
    
    init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
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
        let u = (x + y) * freq + (CGFloat(tin.frameCount) / 120.0)
        let z = noise(x: u, y: 0.0, z: 0.0) * amp
        rot += z
        if child != nil {
            child?.process()
        }
    }
    
    
    func render() {
        tin.pushState()
        tin.translate(dx: x, dy: y)
        tin.rotate(by: rot)
        
        tin.rect(x: -w / 2.0, y: 0.0, w: w, h: h)
        
        if (child != nil) {
            child?.render()
        }
        tin.popState()
    }
    
}
