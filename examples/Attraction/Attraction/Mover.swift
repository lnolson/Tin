//
//  Mover.swift
//  Attraction
//
//  Created by Loren Olson on 12/28/16.
//  Copyright © 2016 ASU. All rights reserved.
//

import Foundation
import Tin

class Mover {
    var location: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var radius: CGFloat = 8.0
    var mass: CGFloat = 1.0
    var angle: CGFloat = 0.0
    var aVelocity: CGFloat = 0.0
    var aAcceleration: CGFloat = 0.0
    
    
    init( x: CGFloat, y: CGFloat ) {
        location = TVector2(x: x, y: y)
        velocity = TVector2()
        acceleration = TVector2()
    }
    
    func applyForce( force: TVector2 ) {
        let f = force / mass
        acceleration = acceleration + f
    }
    
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: 3.0)
        location = location + velocity
        
        angle = velocity.heading()
        
        acceleration = acceleration * 0.0
    }
    
    func render() {
        
        tin.pushState()
        
        tin.translate(dx: CGFloat(location.x), dy: CGFloat(location.y))
        tin.rotate(by: CGFloat(angle))
        
        tin.setStrokeColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        tin.setFillColor(red: 0.7, green: 0.2, blue: 0.1, alpha: 1.0)
        //cu.stroke = true
        //cu.fill = true
        tin.rect(left: -radius, bottom: -radius / 2.0, right: radius * 2.0, top: radius)
        
        tin.popState()
        
    }
    
    func attract( m: Mover ) -> TVector2 {
        var force = location - m.location
        var distance = force.magnitude
        distance = constrain(value: distance, min: 5.0, max: 25.0)
        force.normalize()
        let g: CGFloat = 0.4
        let strength = (g * mass * m.mass) / (distance * distance)
        force = force * strength
        return force
    }
    
    
}

