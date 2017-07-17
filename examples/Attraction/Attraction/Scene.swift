//
//  Scene.swift
//  Attraction
//
//  Created by Loren Olson on 5/31/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin



class Scene: TScene {
    
    var movers: [Mover] = []

    
    
    
    override func setup() {
        var maxX = 100.0
        var maxY = 100.0
        if let view = view {
            maxX = Double(view.frame.width)
            maxY = Double(view.frame.height)
        }
        
        for _ in 0...210 {
            
            let x = TRandom.next(max: maxX)
            let y = TRandom.next(max: maxY)
            
            debug(" mover \(x),\(y)")
            let mover = Mover(x: x, y: y)
            movers.append(mover)
        }
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
