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


// http://stackoverflow.com/questions/39486362/how-to-cast-generic-number-type-t-to-cgfloat

public protocol NumericFloatingPoint : Comparable, Equatable, BinaryFloatingPoint {
    init(_ value: Float)
    init(_ value: Double)
    init(_ value: CGFloat)
    
    // 'shadow method' that allows instances of Numeric
    // to coerce themselves to another Numeric type
    func _asOther<T:NumericFloatingPoint>() -> T
}

extension NumericFloatingPoint {
    
    // Default implementation of init(fromNumeric:) simply gets the inputted value
    // to coerce itself to the same type as the initialiser is called on
    // (the generic parameter T in _asOther() is inferred to be the same type as self)
    init<T:NumericFloatingPoint>(fromNumeric numeric: T) { self = numeric._asOther() }
}

// Implementations of _asOther() – they simply call the given initialisers listed
// in the protocol requirement (it's required for them to be repeated like this,
// as the compiler won't know which initialiser you're referring to otherwise)
extension Float   : NumericFloatingPoint { public func _asOther<T:NumericFloatingPoint>() -> T { return T(self) }}
extension Double  : NumericFloatingPoint { public func _asOther<T:NumericFloatingPoint>() -> T { return T(self) }}
extension CGFloat : NumericFloatingPoint { public func _asOther<T:NumericFloatingPoint>() -> T { return T(self) }}


public protocol TinRenderProtocol {
    
    var delegate: Tin { get set }
    
    // rendering setup
    func prepare(frame: NSRect)
    
    
    // rendering cycle
    func prepareForUpdate(frame: NSRect)
    func didFinishUpdate()
    
    
    // drawing methods
    func background<T>(red: T, green: T, blue: T) where T: NumericFloatingPoint
    
    func ellipse(inRect rect: CGRect)
    func rect(withRect rect: CGRect)
    
    func line<T>(x1: T, y1: T, x2: T, y2: T) where T: NumericFloatingPoint
    func lineWidth<T>(_ width: T) where T: NumericFloatingPoint
    func triangle<T>(x1: T, y1: T, x2: T, y2: T, x3: T, y3: T) where T: NumericFloatingPoint
    
    func pathBegin()
    func pathVertex(at point: CGPoint)
    func pathAddCurve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    func pathClose()
    func pathEnd()
    
    
    // color state
    func setStrokeColor<T>(red: T, green: T, blue: T, alpha: T) where T: NumericFloatingPoint
    func setFillColor<T>(red: T, green: T, blue: T, alpha: T) where T: NumericFloatingPoint
    func strokeColor() -> NSColor
    func fillColor() -> NSColor
    
    
    // context state & transformations
    func pushState()
    func popState()
    func translate<T>(dx: T, dy: T) where T: NumericFloatingPoint
    func rotate<T>(by angle: T) where T: NumericFloatingPoint
    func scale<T>(by amount: T) where T: NumericFloatingPoint
    
    
    // image & text
    func image<T>(image: TImage, x: T, y: T) where T: NumericFloatingPoint
    func text<T>(message: String, font: TFont, x: T, y: T) where T: NumericFloatingPoint
    
}


public class Tin {
    
    public var fill = true
    public var stroke = true
    public var size: NSSize = NSSize(width: 0, height: 0)
    public var midX: CGFloat = 0.0
    public var midY: CGFloat = 0.0
    public var mouseX: CGFloat = 0.0
    public var mouseY: CGFloat = 0.0
    public var pmouseX: CGFloat = 0.0
    public var pmouseY: CGFloat = 0.0
    public var frameCount = 0
    
    var pathVertexCount = 0
    
    public var render: TinRenderProtocol?
    
    
    
    init() {
        render = nil
    }
    
    
    func makeRenderer() {
        render = CoreGraphicsRenderer(delegate:self)
    }
    
    
    func prepare(frame: NSRect) {
        render?.delegate = self
        render?.prepare(frame: frame)
        reset(width: frame.width, height: frame.height)
    }
    
    
    // MARK: - Rendering cycle
    
    
    func prepareForUpdate(frame: NSRect) {
        render?.prepareForUpdate(frame: frame)
    }
    
    
    func didFinishUpdate() {
        render?.didFinishUpdate()
    }
    
    
    
    func reset(width: CGFloat, height: CGFloat) {
        size = NSSize(width: width, height: height)
        midX = width / 2.0
        midY = height / 2.0
        fill = true
        stroke = true
        lineWidth(2.0)
        setFillColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        setStrokeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    }
    
    
    // MARK: - Drawing methods
    
    
    public func background<T>(red: T, green: T, blue: T) where T: NumericFloatingPoint {
        render?.background(red: red, green: green, blue: blue)
    }
    
    public func background<T>(gray: T) where T: NumericFloatingPoint {
        render?.background(red: gray, green: gray, blue: gray)
    }
    
    public func background(color: NSColor) {
        render?.background(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent)
    }
    
    
    // Ellipse methods
    
    // Draw an ellipse. Input is left,bottom and right,top coordinates.
    public func ellipse<T>(left: T, bottom: T, right: T, top: T) where T: NumericFloatingPoint {
        let x = CGFloat(fromNumeric: left)
        let y = CGFloat(fromNumeric: bottom)
        let w = CGFloat(fromNumeric: right - left + 1.0)
        let h = CGFloat(fromNumeric: top - bottom + 1.0)
        let r = CGRect(x: x, y: y, width: w, height: h)
        render?.ellipse(inRect: r)
    }
    
    // Draw an ellipse. Input is left,bottom coordinate and width,height size.
    public func ellipse<T>(x: T, y: T, width: T, height: T) where T: NumericFloatingPoint {
        let r = CGRect(x: CGFloat(fromNumeric: x), y: CGFloat(fromNumeric: y), width: CGFloat(fromNumeric: width), height: CGFloat(fromNumeric: height))
        render?.ellipse(inRect: r)
    }
    
    // Draw an ellipse. Input is origin (left,bottom) as CGPoint and size as CGSize
    public func ellipse(origin: CGPoint, size: CGSize) {
        let r = CGRect(origin: origin, size: size)
        render?.ellipse(inRect: r)
    }
    
    // Draw an ellipse. Input is centerX,centerY coordinate and width,height size.
    public func ellipse<T>(centerX: T, centerY: T, width: T, height: T) where T: NumericFloatingPoint {
        let x = CGFloat(fromNumeric: centerX - width / 2.0)
        let y = CGFloat(fromNumeric: centerY - height / 2.0)
        let w = CGFloat(fromNumeric: width)
        let h = CGFloat(fromNumeric: height)
        let r = CGRect(x: x, y: y, width: w, height: h)
        render?.ellipse(inRect: r)
    }
    
    // Draw an ellipse. Input is center as CGPoint and size as CGSize
    public func ellipse(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width/2.0, y: center.y - size.height/2.0)
        let r = CGRect(origin: origin, size: size)
        render?.ellipse(inRect: r)
    }
    
    // Draw an ellipse. Input is a CGRect struct.
    public func ellipse(inRect rect: CGRect) {
        render?.ellipse(inRect: rect)
    }
    
    
    // Line methods
    
    public func line<T>(x1: T, y1: T, x2: T, y2: T) where T: NumericFloatingPoint {
        render?.line(x1: x1, y1: y1, x2: x2, y2: y2)
    }
    
    public func lineWidth<T>(_ width: T) where T: NumericFloatingPoint {
        render?.lineWidth(width)
    }
    
    
    // Rectangle methods
    
    // Draw a rectangle. Input is left,bottom and right,top coordinates.
    public func rect<T>(left: T, bottom: T, right: T, top: T) where T: NumericFloatingPoint {
        let x = CGFloat(fromNumeric: left)
        let y = CGFloat(fromNumeric: bottom)
        let w = CGFloat(fromNumeric: right - left + 1.0)
        let h = CGFloat(fromNumeric: top - bottom + 1.0)
        let r = CGRect(x: x, y: y, width: w, height: h)
        render?.rect(withRect: r)
    }
    
    // Draw a rectangle. Input is left,bottom coordinate and width,height size.
    public func rect<T>(x: T, y: T, width: T, height: T) where T: NumericFloatingPoint {
        let r = CGRect(x: CGFloat(fromNumeric: x), y: CGFloat(fromNumeric: y), width: CGFloat(fromNumeric: width), height: CGFloat(fromNumeric: height))
        render?.rect(withRect: r)
    }
    
    // Draw a rectangle. Input is origin (left,bottom) as CGPoint and size as CGSize
    public func rect(origin: CGPoint, size: CGSize) {
        let r = CGRect(origin: origin, size: size)
        render?.rect(withRect: r)
    }
    
    // Draw a rectangle. Input is centerX,centerY coordinate and width,height size.
    public func rect<T>(centerX: T, centerY: T, width: T, height: T) where T: NumericFloatingPoint {
        let x = CGFloat(fromNumeric: centerX - width / 2.0)
        let y = CGFloat(fromNumeric: centerY - height / 2.0)
        let w = CGFloat(fromNumeric: width)
        let h = CGFloat(fromNumeric: height)
        let r = CGRect(x: x, y: y, width: w, height: h)
        render?.rect(withRect: r)
    }
    
    // Draw a rectangle. Input is center as CGPoint and size as CGSize
    public func rect(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width/2.0, y: center.y - size.height/2.0)
        let r = CGRect(origin: origin, size: size)
        render?.rect(withRect: r)
    }
    
    // Draw a rectangle. Input is a CGRect struct.
    public func rect(withRect rect: CGRect) {
        render?.rect(withRect: rect)
    }
    
    
    
    public func triangle<T>(x1: T, y1: T, x2: T, y2: T, x3: T, y3: T) where T: NumericFloatingPoint {
        render?.triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3)
    }
    
    
    // Path methods
    
    
    // Create a new path.
    public func pathBegin() {
        render?.pathBegin()
        pathVertexCount = 0
    }
    
    // Add a new point to the current path. (input 2 CGFloats)
    public func pathVertex<T>(x: T, y: T) where T: NumericFloatingPoint {
        let point = CGPoint(x: CGFloat(fromNumeric: x), y: CGFloat(fromNumeric: y))
        render?.pathVertex(at: point)
        pathVertexCount += 1
    }
    
    // Add a new point to the current path. (input CGPoint)
    public func pathVertex(at point: CGPoint) {
        render?.pathVertex(at: point)
        pathVertexCount += 1
    }
    
    // Add a bezier curve to the current path
    public func pathAddCurve(to: CGPoint, control1: CGPoint, control2: CGPoint) {
        render?.pathAddCurve(to: to, control1: control1, control2: control2)
        pathVertexCount += 4
    }
    
    // Close the current line, connecting the current point to the first point.
    public func pathClose() {
        render?.pathClose()
        pathEnd()
    }
    
    // Stroke/Fill the current path.
    public func pathEnd() {
        render?.pathEnd()
        pathVertexCount = 0
    }
    
    
    // MARK: - Color state
    
    
    public func setStrokeColor<T>(red: T, green: T, blue: T, alpha: T) where T: NumericFloatingPoint {
        render?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public func setStrokeColor<T>(gray: T, alpha: T) where T: NumericFloatingPoint {
        render?.setStrokeColor(red: gray, green: gray, blue: gray, alpha: alpha)
    }
    
    public func setStrokeColor<T>(gray: T) where T: NumericFloatingPoint {
        render?.setStrokeColor(red: gray, green: gray, blue: gray, alpha: 1.0)
    }
    
    public func setStrokeColor(color: NSColor) {
        render?.setStrokeColor(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent, alpha: color.alphaComponent)
    }
    
    
    public func setFillColor<T>(red: T, green: T, blue: T, alpha: T) where T: NumericFloatingPoint {
        render?.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public func setFillColor<T>(gray: T, alpha: T) where T: NumericFloatingPoint {
        render?.setFillColor(red: gray, green: gray, blue: gray, alpha: alpha)
    }
    
    public func setFillColor<T>(gray: T) where T: NumericFloatingPoint {
        render?.setFillColor(red: gray, green: gray, blue: gray, alpha: 1.0)
    }
    
    public func setFillColor(color: NSColor) {
        render?.setFillColor(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent, alpha: color.alphaComponent)
    }
    
    
    public func strokeColor() -> NSColor {
        return (render?.strokeColor())!
    }
    
    public func fillColor() -> NSColor {
        return (render?.fillColor())!
    }
    
    
    // MARK: - Context state and Transformations
    
    
    public func pushState() {
        render?.pushState()
    }
    
    public func popState() {
        render?.popState()
    }
    
    public func translate<T>(dx: T, dy: T) where T: NumericFloatingPoint {
        render?.translate(dx: dx, dy: dy)
    }
    
    public func rotate<T>(by angle: T) where T: NumericFloatingPoint {
        render?.rotate(by: angle)
    }
    
    public func scale<T>(by amount: T) where T: NumericFloatingPoint {
        render?.scale(by: amount)
    }
    
    
    // MARK: - Image
    
    
    public func image<T>(image: TImage, x: T, y: T) where T: NumericFloatingPoint {
        render?.image(image: image, x: x, y: y)
    }
    
    
    // MARK: - Text
    
    
    public func text<T>(message: String, font: TFont, x: T, y: T) where T: NumericFloatingPoint {
        render?.text(message: message, font: font, x: x, y: y)
    }
    
    
    public func mouseMoved(to point: CGPoint) {
        pmouseX = mouseX
        pmouseY = mouseY
        mouseX = point.x
        mouseY = point.y
    }
    
    func updateFrameCount() {
        frameCount += 1
    }
    
}
