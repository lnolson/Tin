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
        
        debug("tin size is \(tin.size)")
        
        
        snowman = TImage(contentsOfFileInBundle: "Snowman-200.jpg")
        logo = TImage(contentsOfFileInBundle: "Swift.png")
        
        font = TFont(fontName: "Helvetica Neue Medium", ofSize: 32.0)
    }
    
    
    override func update() {
        
        tin.background(red: 0.5, green: 0.5, blue: 0.5)
        //tin.background(gray: 0.5)
        
        
        
        tin.lineWidth(2.0)
        
        tin.fill = true
        tin.stroke = true
        tin.setFillColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0)
        tin.setStrokeColor(red: 0.1, green: 0.05, blue: 0.05, alpha: 1.0)
        tin.rect(x: tin.midX - 50.0, y: tin.midY - 50.0, width: 100.0, height: 100.0)
        
        tin.rect(left: 5, bottom: 5, right: 20, top: 20)
        
        tin.rect(withRect: CGRect(x: 1000, y: 10, width: 30, height: 100))
        let o = CGPoint(x: 1050, y: 10)
        let s = CGSize(width: 30, height: 100)
        tin.rect(origin: o, size: s)
        
        tin.rect(centerX: tin.midX, centerY: tin.midY, width: 50.0, height: 50.0)
        
        tin.setFillColor(red: 0.6, green: 0.1, blue: 0.2, alpha: 1.0)
        //tin.ellipse(x: tin.midX - 50.0, y: tin.midY + 75.0, width: 100.0, height: 100.0)
        tin.ellipse(centerX: tin.midX, centerY: tin.midY + 125.0, width: 100.0, height: 100.0)
        
        tin.lineWidth(5.0)
        tin.line(x1: tin.midX - 400.0, y1: tin.midY - 100.0, x2: tin.midX + 400.0, y2: tin.midY - 100)
        
        
        tin.lineWidth(2.0)
        //tin.setFillColor(red: 0.3, green: 0.2, blue: 0.8, alpha: 1.0)
        tin.setFillColor(color: NSColor(red: 0.3, green: 0.2, blue: 0.8, alpha: 1.0))
        tin.stroke = true
        tin.triangle(x1: tin.midX, y1: tin.size.height - 20.0, x2: tin.midX - 50.0, y2: tin.size.height - 100.0, x3: tin.midX + 50.0, y3: tin.size.height - 100.0)
        
        tin.lineWidth(3.0)
        tin.stroke = true
        tin.fill = true
        tin.pathBegin()
        tin.pathVertex(x: 50.0, y: 50.0)
        tin.pathVertex(x: 125.0, y: 100.0)
        tin.pathVertex(x: 50.0, y: 150.0)
        tin.pathEnd()
        
        tin.fill = false
        tin.lineWidth(15.0)
        tin.pathBegin()
        tin.pathVertex(x: 150.0, y: 50.0)
        tin.pathAddCurve(to: CGPoint(x: 300.0, y: 180.0), control1: CGPoint(x: 230.0, y: 50.0), control2: CGPoint(x: 300.0, y: 100.0))
        tin.pathEnd()
        
        
        tin.setAlpha(1.0)
        tin.image(image: snowman!, x: 800.0, y: 300.0)
        tin.setAlpha(1.0)
        tin.image(image: logo!, x: 200.0, y: 300.0)
        
        tin.setAlpha(0.5)
        if let f = font {
            tin.setFillColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            f.horizontalAlignment = .center
            f.verticalAlignment = .baseline
            f.lineHeightMultiple = 1.0
            f.paragraphAlignment = .center
            f.kerning = 0.0
            tin.text(message: "Tin", font: f, x: tin.midX, y: 50.0)
            
            tin.setAlpha(1.0)
            let rect = NSRect(x: tin.midX - 200.0, y: 20.0, width: 400.0, height: 90.0)
            tin.fill = false
            tin.setStrokeColor(gray: 0.05)
            tin.roundedRect(rect: rect, xRadius: 5.0, yRadius: 5.0)
        }
        
        //stopUpdates()
        
    }
    
    
    func brightness(image: TImage, factor: CGFloat) {
        image.loadPixels()
        let w = Int(image.width)
        let h = Int(image.height)
        for y in 0 ..< h {
            for x in 0 ..< w {
                var pixel = image.pixel(atX: x, y: y)
                let scaledRed = CGFloat(pixel.red) * factor
                let scaledGreen = CGFloat(pixel.green) * factor
                let scaledBlue = CGFloat(pixel.blue) * factor
                
                pixel.red = UInt8(constrain(value: scaledRed, min: 0.0, max: 255.0))
                pixel.green = UInt8(constrain(value: scaledGreen, min: 0.0, max: 255.0))
                pixel.blue = UInt8(constrain(value: scaledBlue, min: 0.0, max: 255.0))
                image.set(pixel: pixel, x: x, y: y)
            }
        }
        image.savePixels()
    }
    
    
    override func mouseUp() {
        if let img = snowman {
            brightness(image: img, factor: 1.5)
        }
    }
    
}
