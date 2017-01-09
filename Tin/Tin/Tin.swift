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
    
    var delegate: Tin { get set }
    
    func prepare(frame: NSRect)
    func prepareForUpdate(frame: NSRect)
    func didFinishUpdate()
    
    
    func background(red: CGFloat, green: CGFloat, blue: CGFloat)
    func rect(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat)
    func rect(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat)
    func line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat)
    func lineWidth(_ width: CGFloat)
    func ellipse(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat)
    func triangle(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat)
    func beginPath()
    func pathVertex(x: CGFloat, y: CGFloat)
    func closePath()
    func endPath()
    func setStrokeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    func setFillColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    func strokeColor() -> NSColor
    func fillColor() -> NSColor
    func pushState()
    func popState()
    func translate(dx: CGFloat, dy: CGFloat)
    func rotate(by angle: CGFloat)
    func scale(by amount: CGFloat)
    func image(x: CGFloat, y: CGFloat, image: TImage)
    func text(message: String, x: CGFloat, y: CGFloat, font: TFont)
    
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
    
    
    public func background(red: CGFloat, green: CGFloat, blue: CGFloat) {
        render?.background(red: red, green: green, blue: blue)
    }
    
    
    public func rect(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        render?.rect(x1: x1, y1: y1, x2: x2, y2: y2)
    }
    
    
    public func rect(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        render?.rect(x: x, y: y, w: w, h: h)
    }
    
    
    public func line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        render?.line(x1: x1, y1: y1, x2: x2, y2: y2)
    }
    
    
    public func lineWidth(_ width: CGFloat) {
        render?.lineWidth(width)
    }
    
    
    public func ellipse(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        render?.ellipse(x: x, y: y, w: w, h: h)
    }
    
    
    public func triangle(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat) {
        render?.triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3)
    }
    
    
    public func beginPath() {
        render?.beginPath()
        pathVertexCount = 0
    }
    
    
    public func pathVertex(x: CGFloat, y: CGFloat) {
        render?.pathVertex(x: x, y: y)
        pathVertexCount += 1
    }
    
    
    public func closePath() {
        render?.closePath()
        endPath()
    }
    
    
    public func endPath() {
        render?.endPath()
        pathVertexCount = 0
    }
    
    
    public func setStrokeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        render?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    public func setFillColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        render?.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public func strokeColor() -> NSColor {
        return (render?.strokeColor())!
    }
    
    public func fillColor() -> NSColor {
        return (render?.fillColor())!
    }
    
    
    public func pushState() {
        render?.pushState()
    }
    
    public func popState() {
        render?.popState()
    }
    
    public func translate(dx: CGFloat, dy: CGFloat) {
        render?.translate(dx: dx, dy: dy)
    }
    
    public func rotate(by angle: CGFloat) {
        render?.rotate(by: angle)
    }
    
    public func scale(by amount: CGFloat) {
        render?.scale(by: amount)
    }
    
    public func image(x: CGFloat, y: CGFloat, image: TImage) {
        render?.image(x: x, y: y, image: image)
    }
    
    public func text(message: String, x: CGFloat, y: CGFloat, font: TFont) {
        render?.text(message: message, x: x, y: y, font: font)
    }
    
    
    public func mouseMoved(to point: CGPoint) {
        pmouseX = mouseX
        pmouseY = mouseY
        mouseX = point.x
        mouseY = point.y
    }
    
    public func updateFrameCount() {
        frameCount += 1
    }
    
}
