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
    public var delegate: TinContext
    var currentFillColor: NSColor = NSColor(calibratedRed: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    var currentStrokeColor: NSColor = NSColor(calibratedRed: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    var cglayer: CGLayer?
    public var useLayer = false
    
    init(delegate: TinContext) {
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
        if let context = NSGraphicsContext.current {
            if useLayer && cglayer == nil {
                fb = context.cgContext
                cglayer = CGLayer(context.cgContext, size: CGSize(width: frame.width, height: frame.height), auxiliaryInfo: nil)
                cg = (cglayer?.context)!
                delegate.reset(width: Double(frame.width), height: Double(frame.height))
            }
            else if useLayer == false {
                cg = context.cgContext
                delegate.reset(width: Double(frame.width), height: Double(frame.height))
            }
        }
    }
    
    
    public func didFinishUpdate() {
        if useLayer && cglayer != nil {
            fb?.draw(cglayer!, at: CGPoint(x: 0, y: 0))
        }
    }
    
    
    // MARK: - Drawing methods
    
    
    public func background(red: Double, green: Double, blue: Double) {
        cg.saveGState()
        cg.setFillColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
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
    
    
    public func line(x1: Double, y1: Double, x2: Double, y2: Double) {
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
        cg.move(to: CGPoint(x: CGFloat(x1), y: CGFloat(y1)))
        cg.addLine(to: CGPoint(x: CGFloat(x2), y: CGFloat(y2)))
        cg.drawPath(using: mode)
    }
    
    
    public func lineWidth(_ width: Double) {
        cg.setLineWidth(CGFloat(width))
    }
    
    
    public func rect(withRect rect: CGRect) {
        if delegate.fill {
            cg.fill(rect)
        }
        if delegate.stroke {
            cg.stroke(rect)
        }
    }
    
    
    public func triangle(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
        cg.beginPath()
        cg.move(to: CGPoint(x: CGFloat(x1), y: CGFloat(y1)))
        cg.addLine(to: CGPoint(x: CGFloat(x2), y: CGFloat(y2)))
        cg.addLine(to: CGPoint(x: CGFloat(x3), y: CGFloat(y3)))
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
            if delegate.fill {
                if let path = path {
                    cg.addPath(path)
                }
            }
            cg.strokePath()
        }
    }
    
    
    public func roundedRect(rect: NSRect, xRadius: Double, yRadius: Double) {
        let bezier = NSBezierPath(roundedRect: rect, xRadius: CGFloat(xRadius), yRadius: CGFloat(yRadius))
        if delegate.fill {
            bezier.fill()
        }
        if delegate.stroke {
            bezier.stroke()
        }
    }
    
    
    // MARK: - Color state
    
    
    public func setStrokeColor(red: Double, green: Double, blue: Double, alpha: Double) {
        let r = CGFloat(red)
        let g = CGFloat(green)
        let b = CGFloat(blue)
        let a = CGFloat(alpha)
        cg.setStrokeColor(red: r, green: g, blue: b, alpha: a)
        currentStrokeColor = NSColor(calibratedRed: r, green: g, blue: b, alpha: a)
    }
    
    
    public func setFillColor(red: Double, green: Double, blue: Double, alpha: Double) {
        let r = CGFloat(red)
        let g = CGFloat(green)
        let b = CGFloat(blue)
        let a = CGFloat(alpha)
        cg.setFillColor(red: r, green: g, blue: b, alpha: a)
        currentFillColor = NSColor(calibratedRed: r, green: g, blue: b, alpha: a)
    }
    
    public func strokeColor() -> NSColor {
        return currentStrokeColor
    }
    
    public func fillColor() -> NSColor {
        return currentFillColor
    }
    
    
    public func setAlpha(_ alpha: Double) {
        cg.setAlpha(CGFloat(alpha))
    }
    
    
    // MARK: - Context state
    
    
    public func pushState() {
        cg.saveGState()
    }
    
    public func popState() {
        cg.restoreGState()
    }
    
    
    // MARK: - Transformations
    
    
    public func translate(dx: Double, dy: Double) {
        cg.translateBy(x: CGFloat(dx), y: CGFloat(dy))
    }
    
    public func rotate(by angle: Double) {
        cg.rotate(by: CGFloat(angle))
    }
    
    public func scale(by amount: Double) {
        cg.scaleBy(x: CGFloat(amount), y: CGFloat(amount))
    }
    
    
    // MARK: - Image
    
    public func image(image: TImage, x: Double, y: Double) {
        
        let rect = CGRect(x: x, y: y, width: image.width, height: image.height)
        if let cgimage = image.cgimage {
            cg.draw(cgimage, in: rect)
        }
    }
    
    
    public func image(image: TImage, x: Double, y: Double, width: Double, height: Double) {
        let rect = CGRect(x: x, y: y, width: width, height: height)
        if let cgimage = image.cgimage {
            cg.draw(cgimage, in: rect)
        }
    }
    
    
    // MARK: - Text
    
    public func text(message: String, font: TFont, x: Double, y: Double) {
        let attributes = font.makeAttributes()
        let str: NSAttributedString = NSAttributedString(string: message, attributes: attributes)
        let size = str.size()
        
        // Using NSAttributedString.draw doesn't work correctly with drawing into a CGLayer?
        // Instead, below uses CoreText.
        //str.draw(at: NSPoint(x: x, y: y))
        
        var xPos = CGFloat(x)
        if font.horizontalAlignment == .center {
            xPos = xPos - size.width / 2.0
        }
        else if font.horizontalAlignment == .right {
            xPos = xPos - size.width
        }
        
        var yPos = CGFloat(y) + font.font.descender
        if font.verticalAlignment == .bottom {
            yPos = CGFloat(y)
        }
        else if font.verticalAlignment == .center {
            yPos = CGFloat(y) - size.height / 2.0
        }
        else if font.verticalAlignment == .top {
            yPos = CGFloat(y) - size.height
        }
        
        let textPath = CGPath(rect: CGRect(x: xPos, y: yPos, width: ceil(size.width), height: ceil(size.height)), transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(str)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: str.length), textPath, nil)
        //cg.setShouldSmoothFonts(false)
        
        CTFrameDraw(frame, cg)
    }
    
}

