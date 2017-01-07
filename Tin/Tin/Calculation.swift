//
//  Calculation.swift
//  Tin
//
//  Created by Loren Olson on 10/22/16.
//  Copyright © 2016 ASU. All rights reserved.
//

//  A few global useful computation functions.


import Foundation

/**
 Constrains a value to not exceed a minimum and maximum value.
 
 - Parameter value: The value to be constrained.
 - Parameter min: The lower limit, value will not be less than this.
 - Parameter max: The higher limit, value will not be greater than this.
 
 - Returns: (CGFloat) The constrained value.
 
 */
public func constrain( value: CGFloat, min: CGFloat, max: CGFloat ) -> CGFloat {
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
 - Parameter t: The interpolation value.
 
 - Returns: (CGFloat) The interpolated value.
 
 */
public func lerp(startValue: CGFloat, endValue: CGFloat, t: CGFloat) -> CGFloat {
    return startValue + (endValue - startValue) * t;
}


/**
 Calculates the magnitude of a (2d) vector.
 
 - Parameter x: first vector component.
 - Parameter y: second vector component.
 
 - Returns: (CGFloat) Magnitude (ie length).
 */
public func mag(x: CGFloat, y: CGFloat) -> CGFloat {
    return sqrt((x * x) + (y * y))
}


/**
 Remap a number from one range to another. 
 Numbers outside the input range are not clamped,
 since out of range can be useful.
 Example: If the input range is 0 to 1, and
 output range is 0 to 100. Given the value 0.25,
 the result 25.0 is returned.
 
 - Parameter value: The input value to be re-mapped.
 - Parameter start1: The lower bound of the input range.
 - Parameter stop1: The upper bound of the input range.
 - Parameter start2: The lower bound of the output range.
 - Parameter stop2: The upper bound of the output range.
 
 - Returns: (CGFloat) The re-mapped value.
 */
public func map(value: CGFloat, start1: CGFloat, stop1: CGFloat, start2: CGFloat, stop2: CGFloat) -> CGFloat {
    let result = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
    if result.isNaN {
        print("NaN (not a number)")
    }
    else if result.isInfinite {
        print("Infinity")
    }
    return result
}


/**
 Normalizes a number in another range into a value between 0 and 1.
 
 - Parameter value: The input value that will be normalized.
 - Parameter startValue: The lower bound of the value's current range.
 - Parameter endValue: The upper bound of the value's current range.
 
 - Returns: (CGFloat) Normalized value.
 */
public func norm(value: CGFloat, startValue: CGFloat, endValue: CGFloat) -> CGFloat {
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
public func dist( x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat ) -> CGFloat {
    return sqrt(sq(value:(x2 - x1)) + sq(value:(y2 - y1)))
}


/**
 Calculate the square of a value.
 
 - Parameter value: The value to be squared.
 
 - Returns: (CGFloat) square of value.
 */
public func sq( value: CGFloat ) -> CGFloat {
    return value * value
}


let radiansToDegrees = 180.0 / CGFloat.pi
let degreesToRadians = CGFloat.pi / 180.0

/**
 Convert from Radians to Degrees.
 
 - Parameter radians: The value in radians that will be converted.
 
 - Returns: (CGFloat) The converted value in degrees.
 */
public func toDegrees(radians: CGFloat) -> CGFloat {
    return radians * radiansToDegrees
}


/**
 Convert from Degrees to Radians.
 
 - Parameter degrees: The value in degrees that will be converted.
 
 - Returns: (CGFloat) The converted value in radians.
 */
public func toRadians(degrees: CGFloat) -> CGFloat {
    return degrees * degreesToRadians
}

