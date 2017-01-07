//
//  Graphics.swift
//  Attraction
//
//  Created by Loren Olson on 12/28/16.
//  Copyright © 2016 ASU. All rights reserved.
//

import Cocoa
import Tin


class Graphics: TView {
    
    var movers: [Mover] = []

    override func setup() {
        super.setup()
        frameRate = 60.0
        
        for _ in 0...210 {
            let x = TRandom.next(max: frame.width)
            let y = TRandom.next(max: frame.height)
            debug(" mover \(x),\(y)")
            let mover = Mover(x: x, y: y)
            movers.append(mover)
        }
    }
    
    override func update() {
        
        tin.background(red: 0.5, green: 0.5, blue: 0.5)
        tin.setStrokeColor(red: 0.01, green: 0.01, blue: 0.01, alpha: 1.0)
        tin.setFillColor(red: 0.7, green: 0.2, blue: 0.1, alpha: 1.0)
        tin.lineWidth(1.0)
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
