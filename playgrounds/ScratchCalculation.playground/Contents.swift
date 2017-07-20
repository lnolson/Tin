//: Playground - noun: a place where people can play

import Cocoa
import Tin


var a: Double = 50.0
var c1 = constrain(value: a, min: 0.0, max: 100.0)
var c2 = constrain(value: a, min: 100.0, max: 110.0)


var l1 = lerp(startValue: 0.0, endValue: 100.0, t: 0.5)
var l2 = lerp(startValue: 0.0, endValue: 100.0, t: 0.2)
var l3 = lerp(startValue: 0.0, endValue: 100.0, t: 1.5)


var e = 0.5
var m1 = remap(value: e, start1: 0.0, stop1: 1.0, start2: 0.0, stop2: 100.0)
var m2 = remap(value: e, start1: 0.75, stop1: 1.75, start2: 0.0, stop2: 100.0)
var m3 = remap(value: e, start1: 0.0, stop1: 0.4, start2: 0.0, stop2: 100.0)



var n1 = norm(value: 2.0, startValue: 0.0, endValue: 5.0)


var dist1 = dist(x1: 10.0, y1: 10.0, x2: 11.0, y2: 11.0)


var deg1 = toDegrees(radians: Double.pi)
var deg2 = toDegrees(radians: Double.pi * 2.0)

var rad1 = toRadians(degrees: 360.0)
var rad2 = toRadians(degrees: 180.0)






