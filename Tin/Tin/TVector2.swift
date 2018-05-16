//
//  TVector2.swift
//  Tin
//
//  Created by Loren Olson on 10/3/16.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Foundation

/**
 A structure to represent a two dimensional vector.
 */
public struct TVector2 {
    public var x: Double
    public var y: Double
    
    public var magnitude: Double {
        get {
            return sqrt( x * x + y * y )
        }
        set {
            normalize()
            x = x * newValue
            y = y * newValue
        }
    }
    
    // MARK: - Initializers
    
    public init( x: Double, y: Double ) {
        self.x = x
        self.y = y
    }
    
    public init() {
        self.init( x: 0.0, y: 0.0 )
    }
    
    public init(angle: Double) {
        x = cos(angle)
        y = sin(angle)
    }
    
    
    // MARK: - Type methods
    
    /**
     Calculate the angle, in radians, between two vectors.
     
     - Parameter v1: The first vector.
     - Parameter v2: The second vector.
     
     - Returns: (Double) Result (in radians) angle between v1 and v2.
    */
    public static func angleBetween(v1: TVector2, v2: TVector2) -> Double {
        var n1 = v1
        var n2 = v2
        n1.normalize()
        n2.normalize()
        let dp = dot(v1: n1, v2: n2)
        let result = acos(dp)
        return result
    }
    
    public static func cross(v1: TVector2, v2:TVector2) -> Double {
        return v1.x * v2.y - v1.y * v2.x
    }
    
    public static func distance(v1: TVector2, v2: TVector2) -> Double {
        let dx = v2.x - v1.x
        let dy = v2.y - v1.y
        return sqrt( dx * dx + dy * dy )
    }
    
    public static func dot(v1: TVector2, v2:TVector2) -> Double {
        return v1.x * v2.x + v1.y * v2.y
    }

    
    
    // MARK: - Instance methods
    
    
    public func cross(v: TVector2) -> Double {
        return x * v.y + y * v.x
    }
    
    public func distance(v: TVector2) -> Double {
        let dx = x - v.x
        let dy = y - v.y
        return sqrt( dx * dx + dy * dy )
    }
    
    // TODO: why have this instance method?
    // is this used in a NOC example? If not, remove it.
    public func dot(v: TVector2) -> Double {
        return x * v.x + y * v.y
    }
    
    public func heading() -> Double {
        return atan2(y, x)
    }
    
    public mutating func lerp( v: TVector2, amount: Double ) {
        x = x + (v.x - x) * amount
        y = y + (v.y - y) * amount
    }
    
    public mutating func limit( mag: Double ) {
        if magSq() > (mag * mag) {
            normalize()
            x = x * mag
            y = y * mag
        }
    }
    
    public mutating func normalize() {
        let mag = magnitude
        if mag != 0.0 && mag != 1.0 {
            x = x / mag
            y = y / mag
        }
    }
    
    public mutating func rotate( theta: Double ) {
        let temp = x
        x = x * cos(theta) - y * sin(theta)
        y = temp * sin(theta) + y * cos(theta)
    }
    
    
    // Squared magnitude
    public func magSq() -> Double {
        return x * x + y * y
    }
    
}


// MARK: - Operators

public prefix func +(left: TVector2) -> TVector2 {
    return left
}

public prefix func -(left: TVector2) -> TVector2 {
    return TVector2(x: -left.x, y: -left.y)
}

public func +(left: TVector2, right: TVector2) -> TVector2 {
    let x = left.x + right.x
    let y = left.y + right.y
    return TVector2(x: x, y: y)
}

public func -(left: TVector2, right: TVector2) -> TVector2 {
    let x = left.x - right.x
    let y = left.y - right.y
    return TVector2(x: x, y: y)
}

public func *(left: TVector2, right: TVector2) -> TVector2 {
    let x = left.x * right.x
    let y = left.y * right.y
    return TVector2(x: x, y: y)
}

public func *(left: TVector2, right: Double) -> TVector2 {
    let x = left.x * right
    let y = left.y * right
    return TVector2(x: x, y: y)
}

public func *(left: Double, right: TVector2) -> TVector2 {
    let x = left * right.x
    let y = left * right.y
    return TVector2(x: x, y: y)
}


public func /(left: TVector2, right: TVector2) -> TVector2 {
    let x = left.x / right.x
    let y = left.y / right.y
    return TVector2(x: x, y: y)
}

public func /(left: TVector2, right: Double) -> TVector2 {
    let x = left.x / right
    let y = left.y / right
    return TVector2(x: x, y: y)
}


public func +=(left: inout TVector2, right: TVector2) {
    left = left + right
}

public func -=(left: inout TVector2, right: TVector2) {
    left = left - right
}

public func *=(left: inout TVector2, right: TVector2) {
    left = left * right
}

public func /=(left: inout TVector2, right: TVector2) {
    left = left / right
}

public func *=(left: inout TVector2, right: Double) {
    left = left * right
}

public func /=(left: inout TVector2, right: Double) {
    left = left / right
}

