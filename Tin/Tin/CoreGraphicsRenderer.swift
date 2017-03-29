//
//  CoreGraphicsRenderer.swift
//  Tin
//
//  Created by Loren Olson on 1/4/17.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Cocoa



public class CoreGraphicsRenderer: TinRenderProtocol {
    
    var cg: CGContext
    var fb: CGContext?
    public var delegate: Tin
    var currentFillColor: NSColor = NSColor(calibratedRed: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    var currentStrokeColor: NSColor = NSColor(calibratedRed: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    var cglayer: CGLayer?
    public var useLayer = false
    
    init(delegate: Tin) {
        self.delegate = delegate
        cglayer = nil
        fb = nil
        
        let data = NSMutableData()
        let consumer = CGDataConsumer(data: data)
        var rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        cg = CGContext(consumer: consumer!, mediaBox: &rect, nil)!
    }
    
    
    public func prepare(frame: NSRect) {

    }
    
    
    // MARK: - Rendering cycle
    
    
    public func prepareForUpdate(frame: NSRect) {
        if let context = NSGraphicsContext.current() {
            if useLayer && cglayer == nil {
                fb = context.cgContext
                cglayer = CGLayer(context.cgContext, size: CGSize(width: frame.width, height: frame.height), auxiliaryInfo: nil)
                cg = (cglayer?.context)!
                delegate.reset(width: frame.width, height: frame.height)
            }
            else if useLayer == false {
                cg = context.cgContext
                delegate.reset(width: frame.width, height: frame.height)
            }
        }
    }
    
    
    public func didFinishUpdate() {
        if useLayer && cglayer != nil {
            fb?.draw(cglayer!, at: CGPoint(x: 0, y: 0))
        }
    }
    
    
    // MARK: - Drawing methods
    
    
    public func background<T>(red: T, green: T, blue: T) where T: Numeric {
        cg.saveGState()
        cg.setFillColor(red: CGFloat(fromNumeric: red), green: CGFloat(fromNumeric: green), blue: CGFloat(fromNumeric: blue), alpha: 1.0)
        let r = CGRect(x: 0.0, y: 0.0, width: delegate.size.width, height: delegate.size.height)
        cg.fill(r)
        cg.restoreGState()
    }
    
    
    public func ellipse(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        let r = CGRect(x: x, y: y, width: w, height: h)
        ellipse(inRect: r)
    }
    
    public func ellipse(inRect rect: CGRect) {
        if delegate.fill {
            cg.fillEllipse(in: rect)
        }
        if delegate.stroke {
            cg.strokeEllipse(in: rect)
        }
    }
    
    
    public func line<T>(x1: T, y1: T, x2: T, y2: T) where T: Numeric {
        var mode: CGPathDrawingMode = .fill
        if delegate.fill == false && delegate.stroke == false {
            return
        }
        else if delegate.fill == false && delegate.stroke == true {
            mode = .stroke
        }
        else {
            mode = .fillStroke
        }
        cg.beginPath()
        cg.move(to: CGPoint(x: CGFloat(fromNumeric: x1), y: CGFloat(fromNumeric: y1)))
        cg.addLine(to: CGPoint(x: CGFloat(fromNumeric: x2), y: CGFloat(fromNumeric: y2)))
        cg.drawPath(using: mode)
    }
    
    
    public func lineWidth<T>(_ width: T) where T: Numeric {
        cg.setLineWidth(CGFloat(fromNumeric: width))
    }
    
    
    public func rect(withRect rect: CGRect) {
        if delegate.fill {
            cg.fill(rect)
        }
        if delegate.stroke {
            cg.stroke(rect)
        }
    }
    
    
    public func triangle<T>(x1: T, y1: T, x2: T, y2: T, x3: T, y3: T) where T: Numeric {
        cg.beginPath()
        cg.move(to: CGPoint(x: CGFloat(fromNumeric: x1), y: CGFloat(fromNumeric: y1)))
        cg.addLine(to: CGPoint(x: CGFloat(fromNumeric: x2), y: CGFloat(fromNumeric: y2)))
        cg.addLine(to: CGPoint(x: CGFloat(fromNumeric: x3), y: CGFloat(fromNumeric: y3)))
        cg.closePath()
        var path: CGPath?
        if delegate.fill {
            if delegate.stroke { path = cg.path }
            cg.fillPath()
        }
        if delegate.stroke {
            if delegate.fill { cg.addPath(path!) }
            cg.strokePath()
        }
    }
    
    
    public func pathBegin() {
        cg.beginPath()
    }
    
    
    public func pathVertex(at point: CGPoint) {
        if delegate.pathVertexCount == 0 {
            cg.move(to: point)
        }
        else {
            cg.addLine(to: point)
        }
    }
    
    
    public func pathAddCurve(to: CGPoint, control1: CGPoint, control2: CGPoint) {
        cg.addCurve(to: to, control1: control1, control2: control2)
    }
    
    
    
    public func pathClose() {
        cg.closePath()
    }
    
    
    public func pathEnd() {
        var path: CGPath?
        if delegate.fill {
            if delegate.stroke { path = cg.path }
            cg.fillPath()
        }
        if delegate.stroke {
            if delegate.fill { cg.addPath(path!) }
            cg.strokePath()
        }
    }
    
    
    // MARK: - Color state
    
    
    public func setStrokeColor<T>(red: T, green: T, blue: T, alpha: T) where T: Numeric {
        let r = CGFloat(fromNumeric: red)
        let g = CGFloat(fromNumeric: green)
        let b = CGFloat(fromNumeric: blue)
        let a = CGFloat(fromNumeric: alpha)
        cg.setStrokeColor(red: r, green: g, blue: b, alpha: a)
        currentStrokeColor = NSColor(calibratedRed: r, green: g, blue: b, alpha: a)
    }
    
    
    public func setFillColor<T>(red: T, green: T, blue: T, alpha: T) where T: Numeric {
        let r = CGFloat(fromNumeric: red)
        let g = CGFloat(fromNumeric: green)
        let b = CGFloat(fromNumeric: blue)
        let a = CGFloat(fromNumeric: alpha)
        cg.setFillColor(red: r, green: g, blue: b, alpha: a)
        currentFillColor = NSColor(calibratedRed: r, green: g, blue: b, alpha: a)
    }
    
    public func strokeColor() -> NSColor {
        return currentStrokeColor
    }
    
    public func fillColor() -> NSColor {
        return currentFillColor
    }
    
    
    // MARK: - Context state
    
    
    public func pushState() {
        cg.saveGState()
    }
    
    public func popState() {
        cg.restoreGState()
    }
    
    
    // MARK: - Transformations
    
    
    public func translate<T>(dx: T, dy: T) where T: Numeric {
        cg.translateBy(x: CGFloat(fromNumeric: dx), y: CGFloat(fromNumeric: dy))
    }
    
    public func rotate<T>(by angle: T) where T: Numeric {
        cg.rotate(by: CGFloat(fromNumeric: angle))
    }
    
    // TODO
    public func scale<T>(by amount: T) where T: Numeric {
        cg.scaleBy(x: CGFloat(fromNumeric: amount), y: CGFloat(fromNumeric: amount))
    }
    
    
    // MARK: - Image
    
    public func image<T>(image: TImage, x: T, y: T) where T: Numeric {
        let rect = CGRect(x: CGFloat(fromNumeric: x), y: CGFloat(fromNumeric: y), width: image.width, height: image.height)
        if let cgimage = image.cgimage {
            cg.draw(cgimage, in: rect)
        }
    }
    
    
    public func image<T>(image: TImage, x: T, y: T, width: T, height: T) where T: Numeric {
        let rect = CGRect(x: CGFloat(fromNumeric: x), y: CGFloat(fromNumeric: y), width: CGFloat(fromNumeric: width), height: CGFloat(fromNumeric: height))
        if let cgimage = image.cgimage {
            cg.draw(cgimage, in: rect)
        }
    }
    
    
    // MARK: - Text
    
    public func text<T>(message: String, font: TFont, x: T, y: T) where T: Numeric {
        let attributes = font.makeAttributes()
        let str: NSAttributedString = NSAttributedString(string: message, attributes: attributes)
        let size = str.size()
        
        // Using NSAttributedString.draw doesn't work correctly with drawing into a CGLayer?
        // Instead, below uses CoreText.
        //str.draw(at: NSPoint(x: x, y: y))
        
        var xPos = CGFloat(fromNumeric: x)
        if font.horizontalAlignment == .center {
            xPos = xPos - size.width / 2.0
        }
        else if font.horizontalAlignment == .right {
            xPos = xPos - size.width
        }
        
        var yPos = CGFloat(fromNumeric: y) + font.font.descender
        if font.verticalAlignment == .bottom {
            yPos = CGFloat(fromNumeric: y)
        }
        else if font.verticalAlignment == .center {
            yPos = CGFloat(fromNumeric: y) - size.height / 2.0
        }
        else if font.verticalAlignment == .top {
            yPos = CGFloat(fromNumeric: y) - size.height
        }
        
        let textPath = CGPath(rect: CGRect(x: xPos, y: yPos, width: ceil(size.width), height: ceil(size.height)), transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(str)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: str.length), textPath, nil)
        //cg.setShouldSmoothFonts(false)
        
        CTFrameDraw(frame, cg)
    }
    
}
