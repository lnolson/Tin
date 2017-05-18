//
//  Tin.swift
//  Tin
//
//  Created by Loren Olson on 12/28/16.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Cocoa


public var tin = Tin()


public protocol TinRenderProtocol {
    
    var useLayer: Bool { get set }
    
    var delegate: Tin { get set }
    
    // rendering setup
    func prepare(frame: NSRect)
    
    
    // rendering cycle
    func prepareForUpdate(frame: NSRect)
    func didFinishUpdate()
    
    
    // drawing methods
    func background(red: Double, green: Double, blue: Double)
    
    func ellipse(inRect rect: CGRect)
    func rect(withRect rect: CGRect)
    
    func line(x1: Double, y1: Double, x2: Double, y2: Double)
    func lineWidth(_ width: Double)
    func triangle(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double)
    
    func pathBegin()
    func pathVertex(at point: CGPoint)
    func pathAddCurve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    func pathClose()
    func pathEnd()
    
    func roundedRect(rect: CGRect, xRadius: Double, yRadius: Double)
    
    
    // color state
    func setStrokeColor(red: Double, green: Double, blue: Double, alpha: Double)
    func setFillColor(red: Double, green: Double, blue: Double, alpha: Double)
    func strokeColor() -> NSColor
    func fillColor() -> NSColor
    func setAlpha(_ alpha: Double)
    
    
    // context state & transformations
    func pushState()
    func popState()
    func translate(dx: Double, dy: Double)
    func rotate(by angle: Double)
    func scale(by amount: Double)
    
    
    // image & text
    func image(image: TImage, x: Double, y: Double)
    func image(image: TImage, x: Double, y: Double, width: Double, height: Double)
    func text(message: String, font: TFont, x: Double, y: Double)
    
}



public class Tin {
    
    public var fill = true
    public var stroke = true
    public var size = NSSize(width: 0, height: 0)
    public var midX = 0.0
    public var midY = 0.0
    public var mouseX = 0.0
    public var mouseY = 0.0
    public var pmouseX = 0.0
    public var pmouseY = 0.0
    public var frameCount = 0
    
    var pathVertexCount = 0
    
    public var render: TinRenderProtocol!
    
    
    
    init() {
        render = nil
    }
    
    
    func makeRenderer() {
        render = CoreGraphicsRenderer(delegate:self)
    }
    
    
    func prepare(frame: NSRect) {
        render.delegate = self
        render.prepare(frame: frame)
        reset(width: Double(frame.width), height: Double(frame.height))
    }
    
    
    // MARK: - Rendering cycle
    
    
    func prepareForUpdate(frame: NSRect) {
        render.prepareForUpdate(frame: frame)
    }
    
    
    func didFinishUpdate() {
        render.didFinishUpdate()
    }
    
    
    func resetSize(width: Double, height: Double) {
        size = NSSize(width: width, height: height)
        midX = width / 2.0
        midY = height / 2.0
    }
    
    
    func reset(width: Double, height: Double) {
        resetSize(width: width, height: height)
        fill = true
        stroke = true
        lineWidth(2.0)
        fillColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        strokeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    }
    
    
    // enable "Restore from previous"
    // When enabled, this feature will cause the rendering to be saved in an image buffer.
    // After the double buffer swap, before the next render happens, the image saved
    // in the buffer is restored to the current frame buffer. This allows continuous draw effects.
    // Note, there is a time penalty for saving and restoring the image.
    public func enableRestoreFromPrevious() {
        render.useLayer = true
    }
    
    
    public func disableRestoreFromPrevious() {
        render.useLayer = false
    }
    
    

    
    func mouseMoved(to point: CGPoint) {
        pmouseX = mouseX
        pmouseY = mouseY
        mouseX = Double(point.x)
        mouseY = Double(point.y)
    }
    
    func updateFrameCount() {
        frameCount += 1
    }
    
}


// MARK: - Global drawing methods


// Clear (erase) the background

public func background(red: Double, green: Double, blue: Double) {
    tin.render.background(red: red, green: green, blue: blue)
}

public func background(gray: Double) {
    tin.render.background(red: gray, green: gray, blue: gray)
}

public func background(color: NSColor) {
    tin.render.background(red: Double(color.redComponent), green: Double(color.greenComponent), blue: Double(color.blueComponent))
}

// Ellipse method

// Draw an ellipse. Input is centerX,centerY coordinate and width,height size.
public func ellipse(centerX: Double, centerY: Double, width: Double, height: Double) {
    let x = centerX - width / 2.0
    let y = centerY - height / 2.0
    let r = CGRect(x: x, y: y, width: width, height: height)
    tin.render.ellipse(inRect: r)
}


// Line methods

public func line(x1: Double, y1: Double, x2: Double, y2: Double) {
    tin.render.line(x1: x1, y1: y1, x2: x2, y2: y2)
}

public func lineWidth(_ width: Double) {
    tin.render.lineWidth(width)
}


// Rectangle method

// Draw a rectangle. Input is left,bottom coordinate and width,height size.
public func rect(x: Double, y: Double, width: Double, height: Double) {
    let r = CGRect(x: x, y: y, width: width, height: height)
    tin.render.rect(withRect: r)
}


public func triangle(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
    tin.render.triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3)
}


// Path methods


// Create a new path.
public func pathBegin() {
    tin.render.pathBegin()
    tin.pathVertexCount = 0
}

// Add a new point to the current path. (input 2 CGFloats)
public func pathVertex(x: Double, y: Double) {
    let point = CGPoint(x: x, y: y)
    tin.render.pathVertex(at: point)
    tin.pathVertexCount += 1
}

// Add a bezier curve to the current path
public func pathAddCurve(to: CGPoint, control1: CGPoint, control2: CGPoint) {
    tin.render.pathAddCurve(to: to, control1: control1, control2: control2)
    tin.pathVertexCount += 4
}

// Close the current line, connecting the current point to the first point.
public func pathClose() {
    tin.render.pathClose()
    pathEnd()
}

// Stroke/Fill the current path.
public func pathEnd() {
    tin.render.pathEnd()
    tin.pathVertexCount = 0
}

// Draw a rectangle with rounded corners, specified by xRadius, yRadius
public func roundedRect(rect: CGRect, xRadius: Double, yRadius: Double) {
    tin.render.roundedRect(rect: rect, xRadius: xRadius, yRadius: yRadius)
}


// MARK: - Color state


public func strokeColor(red: Double, green: Double, blue: Double, alpha: Double) {
    tin.stroke = true
    tin.render.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
}

public func strokeColor(gray: Double, alpha: Double) {
    tin.stroke = true
    tin.render.setStrokeColor(red: gray, green: gray, blue: gray, alpha: alpha)
}

public func strokeColor(gray: Double) {
    tin.stroke = true
    tin.render.setStrokeColor(red: gray, green: gray, blue: gray, alpha: 1.0)
}

public func strokeColor(color: NSColor) {
    tin.stroke = true
    tin.render.setStrokeColor(red: Double(color.redComponent), green: Double(color.greenComponent), blue: Double(color.blueComponent), alpha: Double(color.alphaComponent))
}


public func fillColor(red: Double, green: Double, blue: Double, alpha: Double) {
    tin.fill = true
    tin.render.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
}

public func fillColor(gray: Double, alpha: Double) {
    tin.fill = true
    tin.render.setFillColor(red: gray, green: gray, blue: gray, alpha: alpha)
}

public func fillColor(gray: Double) {
    tin.fill = true
    tin.render.setFillColor(red: gray, green: gray, blue: gray, alpha: 1.0)
}

public func fillColor(color: NSColor) {
    tin.fill = true
    tin.render.setFillColor(red: Double(color.redComponent), green: Double(color.greenComponent), blue: Double(color.blueComponent), alpha: Double(color.alphaComponent))
}


public func strokeColor() -> NSColor {
    return tin.render.strokeColor()
}

public func fillColor() -> NSColor {
    return tin.render.fillColor()
}

public func setAlpha(_ alpha: Double) {
    tin.render.setAlpha(alpha)
}

public func strokeDisable() {
    tin.stroke = false
}

public func fillDisable() {
    tin.fill = false
}

public func strokeEnable() {
    tin.stroke = true
}

public func fillEnable() {
    tin.fill = true
}


// MARK: - Context state and Transformations


public func pushState() {
    tin.render.pushState()
}

public func popState() {
    tin.render.popState()
}

public func translate(dx: Double, dy: Double) {
    tin.render.translate(dx: dx, dy: dy)
}

public func rotate(by angle: Double) {
    tin.render.rotate(by: angle)
}

public func scale(by amount: Double) {
    tin.render.scale(by: amount)
}


// MARK: - Image


public func image(image: TImage, x: Double, y: Double) {
    tin.render.image(image: image, x: x, y: y)
}


public func image(image: TImage, x: Double, y: Double, width: Double, height: Double) {
    tin.render.image(image: image, x: x, y: y, width: width, height: height)
}


// MARK: - Text


public func text(message: String, font: TFont, x: Double, y: Double) {
    tin.render.text(message: message, font: font, x: x, y: y)
}

