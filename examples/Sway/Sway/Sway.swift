//
//  Sway.swift
//  Sway
//
//  Created by Loren Olson on 7/17/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


class Sway: TScene {
    
    var segments: [Segment] = []
    
    
    override func setup() {
        var maxX = 1000.0
        if let view = view {
            maxX = Double(view.frame.width)
        }
        
        
        for _ in 0...200 {
            let x = random(max: maxX)
            let y = random(min: 40.0, max: 100.0)
            let w = random(min: 16, max: 22)
            let h = random(min: 90, max: 110)
            let s1 = createPlant(x: x, y: y, w: w, h: h)
            segments.append(s1)
        }
    }
    
    
    override func update() {
        background(red: 0.25, green: 0.25, blue: 0.25)
        
        var r1 = 73.0 / 255.0;
        var g1 = 116.0 / 255.0;
        var b1 = 100.0 / 255.0;
        let r2 = 58.0 / 255.0;
        let g2 = 160.0 / 255.0;
        let b2 = 123.0 / 255.0;
        let rinc = (r2 - r1) / Double(segments.count);
        let ginc = (g2 - g1) / Double(segments.count);
        let binc = (b2 - b1) / Double(segments.count);
        
        
        strokeDisable()
        
        
        for s in segments {
            s.process()
            fillColor(red: r1, green: g1, blue: b1, alpha: 1.0)
            s.render()
            r1 += rinc
            g1 += ginc
            b1 += binc
        }
    }
    
    
    
    func createPlant(x: Double, y: Double, w: Double, h: Double) -> Segment {
        let root = Segment(x: x, y: y, w: w, h: h)
        
        var current = root
        for _ in 0...6 {
            let cw = current.w * 0.85
            let ch = current.h * 0.8
            let child = Segment(x: 0, y: current.h, w: cw, h: ch)
            current.add(child: child)
            current = child
        }
        
        return root
    }
}
