//
//  TColor.swift
//  Tin
//
//  Created by Loren Olson on 3/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa


public struct TPixel {
    public var red: UInt8
    public var green: UInt8
    public var blue: UInt8
    public var alpha: UInt8 = 255
    
    
    public init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    
    public init(red: UInt8, green: UInt8, blue: UInt8) {
        self.init(red: red, green: green, blue: blue, alpha: 255)
    }
    
    
    public init(color: TColor) {
        let r = UInt8(constrain(value: color.red * 255.0, min: 0.0, max: 255.0))
        let g = UInt8(constrain(value: color.red * 255.0, min: 0.0, max: 255.0))
        let b = UInt8(constrain(value: color.red * 255.0, min: 0.0, max: 255.0))
        let a = UInt8(constrain(value: color.red * 255.0, min: 0.0, max: 255.0))
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}



public struct TColor {
    public var red = 0.0
    public var green = 0.0
    public var blue = 0.0
    public var alpha = 1.0
    
    // TODO: provide a set implementation for hue, saturation, value
    //       these write methods should then mutate red, green, blue
    
    // hue - a value from 0-360 https://en.wikipedia.org/wiki/HSL_and_HSV
    //
    public var hue: Double {
        var h = 0.0
        let maxM = max(red, green, blue)
        let minM = min(red, green, blue)
        let delta = maxM - minM
        if delta < 0.00001 {
            return h
        }
        if maxM == red {
            h = (green - blue) / delta
        }
        else if maxM == green {
            h = (blue - red) / delta + 2.0
        }
        else {
            h = (red - green) / delta + 4.0
        }
        h = h * 60.0
        if h < 0.0 {
            h = h + 360.0
        }
        return h
    }
    
    public var saturation: Double {
        var s = 0.0
        let maxM = max(red, green, blue)
        let v = maxM
        if maxM < 0.00001 {
            return s
        }
        let minM = min(red, green, blue)
        let delta = maxM - minM
        s = delta / v
        return s
    }
    
    public var value: Double {
        let v = max(red, green, blue)
        return v
    }
    
    
    public init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    
    public init(pixel: TPixel) {
        red = Double(pixel.red) / 255.0
        green = Double(pixel.green) / 255.0
        blue = Double(pixel.blue) / 255.0
        alpha = Double(pixel.alpha) / 255.0
    }
    
    
    // TODO: add an init for HSV inital values, maybe for grayscale too?
    
    
    public func setFillColor() {
        fillColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    public func setStrokeColor() {
        strokeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    
    // relative luminance https://en.wikipedia.org/wiki/Relative_luminance
    //
    public func luminance() -> Double {
        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
    }
    
    
    public func lightness() -> Double {
        let maxM = max(red, green, blue)
        let minM = min(red, green, blue)
        let l = 0.5 * (maxM + minM)
        return l
    }
    
    
    public func brightness() -> Double {
        return (red + green + blue) / 3.0
    }
    
    
    
}
