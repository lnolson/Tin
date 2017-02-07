//
//  CartView.swift
//  CartDemo
//
//  Created by Loren Olson on 12/29/16.
//  Copyright © 2016 ASU. All rights reserved.
//

import Cocoa
import Tin


class CartView: TView {
    
    var x: CGFloat = 400.0
    var y: CGFloat = 200.0
    var r: CGFloat = 40.0
    let bodyWidth: CGFloat = 200.0
    let bodyHeight: CGFloat = 70.0

    
    override func setup() {
        debug("CartView.setup")
        super.setup()
    }
    
    
    override func update() {
        tin.background(red: 0.5, green: 0.5, blue: 0.5)
        
        // Ground
        tin.setFillColor(red: 0.05, green: 0.4, blue: 0.1, alpha: 1.0)
        tin.stroke = false
        tin.rect(x: 0, y: 0, width: frame.width, height: y-r)
        
        cart()
    }
    
    
    func cart() {
        tin.pushState()
        tin.translate(dx: x, dy: y)
        
        // draw the body of the Cart
        tin.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tin.lineWidth(3.0)
        tin.setStrokeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        tin.stroke = true
        tin.rect(x: -(bodyWidth/2.0), y: 0.0, width: bodyWidth, height: bodyHeight)
        
        // Two wheels
        let wheelBase = (bodyWidth / 2.0) * 0.55
        wheel(wx: -CGFloat(wheelBase))
        wheel(wx:  CGFloat(wheelBase))
        
        tin.popState()
    }
    
    
    func wheel(wx: CGFloat) {
        tin.pushState()
        tin.translate(dx: wx, dy: 0.0)
        let a: CGFloat = -x / r
        tin.rotate(by: a)
        
        tin.ellipse(x: -r, y: -r, width: r * 2, height: r * 2)
        
        // Draw two lines, so we can see wheel rotation
        tin.line(x1: 0.0, y1: -r, x2: 0.0, y2: r)
        tin.line(x1: -r, y1: 0.0, x2: r, y2: 0.0)
 
        tin.popState()
    }
    
    
    override func mouseDown(with event: NSEvent) {
    }
    
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        x = x + (tin.mouseX - tin.pmouseX)
    }
}
