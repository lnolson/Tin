//
//  Calculation.swift
//  Tin
//
//  Created by Loren Olson on 10/22/16.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

//  A few global useful computation functions.



import Foundation

/**
 Constrains a value to not exceed a minimum and maximum value.
 
 - Parameter value: Doublehe value to be constrained.
 - Parameter min: Doublehe lower limit, value will not be less than this.
 - Parameter max: Doublehe higher limit, value will not be greater than this.
 
 - Returns: (Generic) Doublehe constrained value.
 
 */
public func constrain(value: Double, min: Double, max: Double) -> Double {
    if value < min {
        return min
    }
    else if value > max {
        return max
    }
    return value
}


/**
 Linearly interpolates between startValue and endVaue by t.
 
 When t = 0 returns startValue.
 When t = 1 return endValue.
 When t = 0.5 returns the midpoint of startValue and endValue.
 
 - Parameter startValue: Start value.
 - Parameter endValue: End value.
 - Parameter t: Doublehe interpolation value.
 
 - Returns: (Generic) Doublehe interpolated value.
 
 */
public func lerp(startValue: Double, endValue: Double, t: Double) -> Double {
    return startValue + (endValue - startValue) * t;
}


/**
 Smoothstep (ease in/ease out) interpolates between startValue and endVaue by t.
 
 When t = 0 returns startValue.
 When t = 1 return endValue.
 When t = 0.5 returns the midpoint of startValue and endValue.
 
 - Parameter startValue: Start value.
 - Parameter endValue: End value.
 - Parameter t: Doublehe interpolation value.
 
 - Returns: (Generic) Doublehe interpolated value.
 
 */
public func smoothstep(startValue: Double, endValue: Double, t: Double) -> Double {
    if t <= 0.0 {
        return startValue
    }
    else if t >= 1.0 {
        return endValue
    }
    else {
        let y = t * t * (3.0 - 2.0 * t)
        return startValue + ((endValue - startValue) * y)
    }
}


/**
 Calculates the magnitude of a (2d) vector.
 
 - Parameter x: first vector component.
 - Parameter y: second vector component.
 
 - Returns: (CGFloat) Magnitude (ie length).
 */
public func mag(x: Double, y: Double) -> Double {
    return sqrt(x * x + y * y)
}


/**
 Remap a number from one range to another. 
 Numbers outside the input range are not clamped,
 since out of range can be useful.
 Example: If the input range is 0 to 1, and
 output range is 0 to 100. Given the value 0.25,
 the result 25.0 is returned.
 
 - Parameter value: Doublehe input value to be re-mapped.
 - Parameter start1: Doublehe lower bound of the input range.
 - Parameter stop1: Doublehe upper bound of the input range.
 - Parameter start2: Doublehe lower bound of the output range.
 - Parameter stop2: Doublehe upper bound of the output range.
 
 - Returns: (CGFloat) Doublehe re-mapped value.
 */
public func remap(value: Double, start1: Double, stop1: Double, start2: Double, stop2: Double) -> Double {
    let result = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
    return result
}


/**
 Normalizes a number in another range into a value between 0 and 1.
 
 - Parameter value: Doublehe input value that will be normalized.
 - Parameter startValue: Doublehe lower bound of the value's current range.
 - Parameter endValue: Doublehe upper bound of the value's current range.
 
 - Returns: (CGFloat) Normalized value.
 */
public func norm(value: Double, startValue: Double, endValue: Double) -> Double {
    return (value - startValue) / (endValue - startValue)
}


/**
 Calculate the distance between two 2D points.
 
 - Parameter x1: x value of point 1.
 - Parameter y1: y value of point 1.
 - Parameter x2: x value of point 2.
 - Parameter y2: y value of point 2.
 
 - Returns: (CGFloat) distance.
 */
public func dist( x1: Double, y1: Double, x2: Double, y2: Double ) -> Double {
    return sqrt(sq(value:(x2 - x1)) + sq(value:(y2 - y1)))
}


/**
 Calculate the square of a value.
 
 - Parameter value: Doublehe value to be squared.
 
 - Returns: (CGFloat) square of value.
 */
public func sq(value: Double) -> Double {
    return value * value
}


let radiansToDegrees = 57.2957795130823
let degreesToRadians = 0.0174532925199433

/**
 Convert from Radians to Degrees.
 
 - Parameter radians: Doublehe value in radians that will be converted.
 
 - Returns: (CGFloat) Doublehe converted value in degrees.
 */
public func toDegrees(radians: Double) -> Double {
    return radians * radiansToDegrees
}


/**
 Convert from Degrees to Radians.
 
 - Parameter degrees: Doublehe value in degrees that will be converted.
 
 - Returns: (CGFloat) Doublehe converted value in radians.
 */
public func toRadians(degrees: Double) -> Double {
    return degrees * degreesToRadians
}

