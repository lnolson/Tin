//
//  DrawingView.swift
//  SimpleDrawing
//
//  Created by Loren Olson on 1/3/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class DrawingView: TView {
    
    
    var snowman: TImage?
    var logo: TImage?
    var font: TFont?
    
    
    override func setup() {
        super.setup()
        
        snowman = TImage.makeImage(imageFileInBundle: "Snowman-200.jpg")
        logo = TImage.makeImage(imageFileInBundle: "Swift.png")
        
        font = TFont(fontName: "Helvetica Neue Medium", ofSize: 32.0)
    }
    
    
    override func update() {
        
        tin.background(red: 0.5, green: 0.5, blue: 0.5)
        
        
        tin.lineWidth(2.0)
        
        tin.fill = true
        tin.stroke = true
        tin.setFillColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0)
        tin.setStrokeColor(red: 0.1, green: 0.05, blue: 0.05, alpha: 1.0)
        tin.rect(x: tin.midX - 50.0, y: tin.midY - 50.0, w: 100.0, h: 100.0)
        
        tin.setFillColor(red: 0.6, green: 0.1, blue: 0.2, alpha: 1.0)
        tin.ellipse(x: tin.midX - 50.0, y: tin.midY + 75.0, w: 100.0, h: 100.0)
        
        tin.lineWidth(5.0)
        tin.line(x1: tin.midX - 400.0, y1: tin.midY - 100.0, x2: tin.midX + 400.0, y2: tin.midY - 100)
        
        
        tin.lineWidth(2.0)
        tin.setFillColor(red: 0.3, green: 0.2, blue: 0.8, alpha: 1.0)
        tin.stroke = true
        tin.triangle(x1: tin.midX, y1: tin.size.height - 20.0, x2: tin.midX - 50.0, y2: tin.size.height - 100.0, x3: tin.midX + 50.0, y3: tin.size.height - 100.0)
        
        tin.lineWidth(3.0)
        tin.stroke = true
        tin.fill = true
        tin.beginPath()
        tin.pathVertex(x: 50.0, y: 50.0)
        tin.pathVertex(x: 125.0, y: 100.0)
        tin.pathVertex(x: 50.0, y: 150.0)
        tin.endPath()
        
        
        tin.image(x: 800.0, y: 300.0, image: snowman!)
        tin.image(x: 200.0, y: 300.0, image: logo!)
        
        
        if let f = font {
            tin.setFillColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            f.horizontalAlignment = .center
            f.verticalAlignment = .baseline
            f.lineHeightMultiple = 1.0
            f.paragraphAlignment = .center
            f.kerning = 0.0
            tin.text(message: "Tin", x: tin.midX, y: 50.0, font: f)
        }
        
        
        
    }
    
}
