//
//  SwayView.swift
//  Sway
//
//  Created by Loren Olson on 1/6/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class SwayView: TView {
    
    var segments: [Segment] = []


    override func setup() {
        
        for _ in 0...400 {
            let x: CGFloat = TRandom.next(max: frame.width)
            let y: CGFloat = TRandom.next(min: 40.0, max: 100.0)
            let w: CGFloat = TRandom.next(min: 16, max: 22)
            let h: CGFloat = TRandom.next(min: 90, max: 110)
            let s1 = createPlant(x: x, y: y, w: w, h: h)
            segments.append(s1)
        }
    }
    
    
    override func update() {
        tin.background(red: 0.25, green: 0.25, blue: 0.25)
        
        var r1: CGFloat = 73.0 / 255.0;
        var g1: CGFloat = 116.0 / 255.0;
        var b1: CGFloat = 100.0 / 255.0;
        let r2: CGFloat = 58.0 / 255.0;
        let g2: CGFloat = 160.0 / 255.0;
        let b2: CGFloat = 123.0 / 255.0;
        let rinc = (r2 - r1) / CGFloat(segments.count);
        let ginc = (g2 - g1) / CGFloat(segments.count);
        let binc = (b2 - b1) / CGFloat(segments.count);
        
        tin.stroke = false
        
        for s in segments {
            s.process()
            tin.setFillColor(red: r1, green: g1, blue: b1, alpha: 1.0)
            s.render()
            r1 += rinc
            g1 += ginc
            b1 += binc
        }
    }
    
    
    func createPlant(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) -> Segment {
        let a = Segment(x: x, y: y, w: w, h: h)
        
        let bw = w * 0.75
        let bh = h * 0.8
        let b = Segment(x: 0, y: h, w: bw, h: bh)
        a.add(child: b)
        
        let cw = bw * 0.75
        let ch = bh * 0.8
        let c = Segment(x: 0, y: bh, w: cw, h: ch)
        b.add(child: c)
        
        let dw = cw * 0.75
        let dh = ch * 0.8
        let d = Segment(x: 0, y: ch, w: dw, h: dh)
        c.add(child: d)
        
        return a
    }
    
}
