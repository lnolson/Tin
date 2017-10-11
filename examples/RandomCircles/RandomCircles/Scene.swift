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
        
        let x = random(max: tin.width)
        let y = random(max: tin.height)
        
        let r = random(max: 1)
        let g = random(max: 1)
        let b = random(max: 1)
        let a = random(min: 0.25, max: 1.0)
        
        let w = randomGaussian() * 20.0 + 60.0
        
        fillColor(red: r, green: g, blue: b, alpha: a)
        strokeDisable()
        ellipse(centerX: x, centerY: y, width: w, height: w)
    }
    
    
    
    
    
}
