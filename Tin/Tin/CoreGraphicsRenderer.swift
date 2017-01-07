//
//  CoreGraphicsRenderer.swift
//  Tin
//
//  Created by Loren Olson on 1/4/17.
//  Copyright © 2017 ASU. All rights reserved.
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
    
    
    
    
    public func background(red: CGFloat, green: CGFloat, blue: CGFloat) {
        cg.saveGState()
        cg.setFillColor(red: red, green: green, blue: blue, alpha: 1.0)
        let r = CGRect(x: 0.0, y: 0.0, width: delegate.size.width, height: delegate.size.height)
        cg.fill(r)
        cg.restoreGState()
    }
    
    
    public func rect(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        let r = CGRect(x: x1, y: y1, width: x2 - x1 + 1.0, height: y2 - y1 + 1.0)
        if delegate.fill {
            cg.fill(r)
        }
        if delegate.stroke {
            cg.stroke(r)
        }
    }
    
    
    public func rect(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        let r = CGRect(x: x, y: y, width: w, height: h)
        if delegate.fill {
            cg.fill(r)
        }
        if delegate.stroke {
            cg.stroke(r)
        }
    }
    
    
    public func line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
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
        cg.move(to: CGPoint(x: x1, y: y1))
        cg.addLine(to: CGPoint(x: x2, y: y2))
        cg.drawPath(using: mode)
    }
    
    
    public func lineWidth(_ width: CGFloat) {
        cg.setLineWidth(width)
    }
    
    
    public func ellipse(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        let r = CGRect(x: x, y: y, width: w, height: h)
        if delegate.fill {
            cg.fillEllipse(in: r)
        }
        if delegate.stroke {
            cg.strokeEllipse(in: r)
        }
    }
    
    
    public func triangle(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat) {
        cg.beginPath()
        cg.move(to: CGPoint(x: x1, y: y1))
        cg.addLine(to: CGPoint(x: x2, y: y2))
        cg.addLine(to: CGPoint(x: x3, y: y3))
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
    
    
    public func beginPath() {
        cg.beginPath()
    }
    
    
    public func pathVertex(x: CGFloat, y: CGFloat) {
        if delegate.pathVertexCount == 0 {
            cg.move(to: CGPoint(x: x, y: y))
        }
        else {
            cg.addLine(to: CGPoint(x: x, y: y))
        }
    }
    
    
    public func closePath() {
        cg.closePath()
    }
    
    
    public func endPath() {
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
    
    
    public func setStrokeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        cg.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
        currentStrokeColor = NSColor(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    public func setFillColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        cg.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
        currentFillColor = NSColor(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    public func strokeColor() -> NSColor {
        return currentStrokeColor
    }
    
    public func fillColor() -> NSColor {
        return currentFillColor
    }
    
    public func pushState() {
        cg.saveGState()
    }
    
    public func popState() {
        cg.restoreGState()
    }
    
    public func translate(dx: CGFloat, dy: CGFloat) {
        cg.translateBy(x: dx, y: dy)
    }
    
    public func rotate(by angle: CGFloat) {
        cg.rotate(by: angle)
    }
    
    public func scale(by amount: CGFloat) {
        
    }
    
    
    public func image(x: CGFloat, y: CGFloat, image: TImage) {
        let rect = CGRect(x: x, y: y, width: image.width, height: image.height)
        if let cgimage = image.cgimage {
            cg.draw(cgimage, in: rect)
        }
    }
    
    
    public func text(message: String, x: CGFloat, y: CGFloat, font: TFont) {
        let attributes = font.makeAttributes()
        let str: NSAttributedString = NSAttributedString(string: message, attributes: attributes)
        let size = str.size()
        
        // Using NSAttributedString.draw doesn't work correctly with drawing into a CGLayer?
        // Instead, below uses CoreText.
        //str.draw(at: NSPoint(x: x, y: y))
        
        var xPos = x
        if font.horizontalAlignment == .center {
            xPos = x - size.width / 2.0
        }
        else if font.horizontalAlignment == .right {
            xPos = x - size.width
        }
        
        var yPos = y + font.font.descender
        if font.verticalAlignment == .bottom {
            yPos = y
        }
        else if font.verticalAlignment == .center {
            yPos = y - size.height / 2.0
        }
        else if font.verticalAlignment == .top {
            yPos = y - size.height
        }
        
        let textPath = CGPath(rect: CGRect(x: xPos, y: yPos, width: ceil(size.width), height: ceil(size.height)), transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(str)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: str.length), textPath, nil)
        //cg.setShouldSmoothFonts(false)
        
        CTFrameDraw(frame, cg)
    }
    
}
