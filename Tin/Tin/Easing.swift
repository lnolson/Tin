//
//  Easing.swift
//  Tin
//
//  Created by Loren Olson on 8/6/19.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2019 Arizona Board of Regents on behalf of Arizona State University
//

//  A few global useful functions for ease in/ease out calculations.
//

import Foundation


// Some specifics inspired by this reference.
// http://robertpenner.com/easing/
//
// Handy graphical reference to most of these
// https://easings.net/en


// MARK: - constants

private let pi_2 = Double.pi / 2.0


// For all the following easeIn, easeOut, and easeInOut functions...
// - Parameter value: an input Double in the range 0.0 to 1.0. Used to find
//                    an interpolated value for the range start to stop.
// - Parameter start: Beginning of the range for interpolation.
// - Parameter stop: End of the range for interpolation.



// MARK: - linear interpolation (reformulated version of lerp)

public func linear(value: Double, start: Double, stop: Double) -> Double {
    return remap(value: value, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}


// MARK: - Quadratic ease in/out

// Modeled after the parabola y = x^2
public func easeInQuad(value: Double, start: Double, stop: Double) -> Double {
    let t = value * value
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the parabola y = -x^2 + 2x
public func easeOutQuad(value: Double, start: Double, stop: Double) -> Double {
    let t = -(value * (value - 2.0))
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the piecewise quadratic
// y = (1/2)((2x)^2)             ; [0, 0.5)
// y = -(1/2)((2x-1)*(2x-3) - 1) ; [0.5, 1]
public func easeInOutQuad(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 0.5 {
        t = 2.0 * value * value
    }
    else {
        t = (-2.0 * value * value) + (4.0 * value) - 1.0;
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}



// MARK: - Quartic ease in/out

// Modeled after the quartic x^4
public func easeInQuart(value: Double, start: Double, stop: Double) -> Double {
    let t = value * value * value * value
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the quartic y = 1 - (x - 1)^4
public func easeOutQuart(value: Double, start: Double, stop: Double) -> Double {
    let f = value - 1.0
    let t = f * f * f * (1.0 - value) + 1.0
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the piecewise quartic
// y = (1/2)((2x)^4)        ; [0, 0.5)
// y = -(1/2)((2x-2)^4 - 2) ; [0.5, 1]
public func easeInOutQuart(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 0.5 {
        t = 8.0 * value * value * value * value
    }
    else {
        let f = value - 1.0
        t = -8.0 * f * f * f * f + 1.0
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}



// MARK: - Quintic ease in/out

// Modeled after the quintic y = x^5
public func easeInQuint(value: Double, start: Double, stop: Double) -> Double {
    let t = value * value * value * value * value
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the quintic y = (x - 1)^5 + 1
public func easeOutQuint(value: Double, start: Double, stop: Double) -> Double {
    let f = value - 1.0
    let t = f * f * f * f * f + 1.0
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the piecewise quintic
// y = (1/2)((2x)^5)       ; [0, 0.5)
// y = (1/2)((2x-2)^5 + 2) ; [0.5, 1]
public func easeInOutQuint(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 0.5 {
        t = 16.0 * value * value * value * value * value
    }
    else {
        let f = (2.0 * value) - 2.0
        t = 0.5 * f * f * f * f * f + 1.0
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}



// MARK: - Overshooting cubic ease in/out

// Modeled after the overshooting cubic y = x^3-x*sin(x*pi)
public func easeInBack(value: Double, start: Double, stop: Double) -> Double {
    let t = value * value * value - value * sin(value * .pi)
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*sin((1-x)*pi))
public func easeOutBack(value: Double, start: Double, stop: Double) -> Double {
    let f = 1.0 - value
    let t = 1.0 - (f * f * f - f * sin(f * .pi))
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the piecewise overshooting cubic function:
// y = (1/2)*((2x)^3-(2x)*sin(2*x*pi))           ; [0, 0.5)
// y = (1/2)*(1-((1-x)^3-(1-x)*sin((1-x)*pi))+1) ; [0.5, 1]
public func easeInOutBack(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 0.5 {
        let f = 2.0 * value
        t = 0.5 * (f * f * f - f * sin(f * .pi))
    }
    else {
        let f = 1.0 - (2.0 * value - 1.0)
        t = 0.5 * (1.0 - (f * f * f - f * sin(f * .pi))) + 0.5
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}



// MARK: - Bouncing ease in/out

public func easeInBounce(value: Double, start: Double, stop: Double) -> Double {
    let t = 1.0 - easeOutBounce(value: 1.0 - value, start: 0, stop: 1)
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

public func easeOutBounce(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 4.0 / 11.0 {
        t = (121.0 * value * value) / 16.0
    }
    else if value < 8.0 / 11.0 {
        t = (363.0 / 40.0 * value * value) - (99.0 / 10.0 * value) + 17.0 / 5.0
    }
    else if value < 9.0 / 10.0 {
        t = (4356.0 / 361.0 * value * value) - (35442.0 / 1805.0 * value) + 16061.0 / 1805.0
    }
    else {
        t = (54.0 / 5.0 * value * value) - (513.0 / 25.0 * value) + 268.0 / 25.0
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

public func easeInOutBounce(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 0.5 {
        t = 0.5 * easeInBounce(value: value * 2.0, start: 0, stop: 1)
    }
    else {
        t = 0.5 * easeOutBounce(value: value * 2.0 - 1.0, start: 0, stop: 1) + 0.5
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}



// MARK: - Elastic ease in/out

// Modeled after the damped sine wave y = sin(13pi/2*x)*pow(2, 10 * (x - 1))
public func easeInElastic(value: Double, start: Double, stop: Double) -> Double {
    let t = sin(13.0 * pi_2 * value) * pow(2.0, 10.0 * (value - 1.0))
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
public func easeOutElastic(value: Double, start: Double, stop: Double) -> Double {
    let t = sin(-13.0 * pi_2 * (value + 1.0)) * pow(2.0, -10.0 * value) + 1.0
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}

// Modeled after the piecewise exponentially-damped sine wave:
// y = (1/2)*sin(13pi/2*(2*x))*pow(2, 10 * ((2*x) - 1))      ; [0,0.5)
// y = (1/2)*(sin(-13pi/2*((2x-1)+1))*pow(2,-10(2*x-1)) + 2) ; [0.5, 1]
public func easeInOutElastic(value: Double, start: Double, stop: Double) -> Double {
    var t = 0.0
    if value < 0.5 {
        t = 0.5 * sin(13.0 * pi_2 * (2.0 * value)) * pow(2.0, 10.0 * ((2.0 * value) - 1.0))
    }
    else {
        t = 0.5 * (sin(-13.0 * pi_2 * ((2.0 * value - 1.0) + 1.0)) * pow(2.0, -10.0 * (2.0 * value - 1.0)) + 2.0)
    }
    return remap(value: t, start1: 0.0, stop1: 1.0, start2: start, stop2: stop)
}
