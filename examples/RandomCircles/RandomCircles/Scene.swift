//
//  Scene.swift
//  RandomCircles
//
//  Created by Loren Olson on 7/17/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin



class Scene: TScene {
    
    
    var needsClear = true
    
    
    override func setup() {
        
    }
    
    
    override func update() {
        if needsClear {
            Swift.print("clear")
            background(red: 0.5, green: 0.5, blue: 0.5)
            needsClear = false
        }
        
        let x = TRandom.next(max: Double(tin.size.width))
        let y = TRandom.next(max: Double(tin.size.height))
        
        let r = TRandom.next(max: 1.0)
        let g = TRandom.next(max: 1.0)
        let b = TRandom.next(max: 1.0)
        let a = TRandom.next(min: 0.25, max: 1.0)
        
        fillColor(red: r, green: g, blue: b, alpha: a)
        strokeDisable()
        ellipse(centerX: x, centerY: y, width: 60.0, height: 60.0)
    }
    
    
    
    
    
}
