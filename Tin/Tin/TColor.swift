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
}



public struct TColor {
    public var red: CGFloat = 0.0
    public var green: CGFloat = 0.0
    public var blue: CGFloat = 0.0
    public var alpha: CGFloat = 1.0
    
    // TODO: provide a set implementation for hue, saturation, value
    //       these write methods should then mutate red, green, blue
    
    // hue - a value from 0-360 https://en.wikipedia.org/wiki/HSL_and_HSV
    //
    public var hue: CGFloat {
        var h: CGFloat = 0.0
        let maxM: CGFloat = max(red, green, blue)
        let minM: CGFloat = min(red, green, blue)
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
    
    public var saturation: CGFloat {
        var s: CGFloat = 0.0
        let maxM: CGFloat = max(red, green, blue)
        let v = maxM
        if maxM < 0.00001 {
            return s
        }
        let minM: CGFloat = min(red, green, blue)
        let delta = maxM - minM
        s = delta / v
        return s
    }
    
    public var value: CGFloat {
        let v: CGFloat = max(red, green, blue)
        return v
    }
    
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    
    public init(pixel: TPixel) {
        red = CGFloat(pixel.red) / 255.0
        green = CGFloat(pixel.green) / 255.0
        blue = CGFloat(pixel.blue) / 255.0
        alpha = CGFloat(pixel.alpha) / 255.0
    }
    
    
    // TODO: add an init for HSV inital values, maybe for grayscale too?
    
    
    public func setFillColor() {
        tin.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    public func setStrokeColor() {
        tin.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    
    // relative luminance https://en.wikipedia.org/wiki/Relative_luminance
    //
    public func luminance() -> CGFloat {
        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
    }
    
    
    public func lightness() -> CGFloat {
        let maxM: CGFloat = max(red, green, blue)
        let minM: CGFloat = min(red, green, blue)
        let l = 0.5 * (maxM + minM)
        return l
    }
    
    
    public func brightness() -> CGFloat {
        return (red + green + blue) / 3.0
    }
    
    
    
}
