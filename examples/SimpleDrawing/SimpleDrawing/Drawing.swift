//
//  Drawing.swift
//  SimpleDrawing
//
//  Created by Loren Olson on 5/31/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


class Drawing: TScene {
    
    
    var snowman: TImage?
    var logo: TImage?
    var font: TFont?
    
    
    
    override init() {
        super.init()
        
        
    }
    
    
    override func setup() {
        print("Drawing setup")
        snowman = TImage(contentsOfFileInBundle: "Snowman-200.jpg")
        logo = TImage(contentsOfFileInBundle: "Swift.png")
        
        let v = remap(value: 0.5, start1: 1.0, stop1: 1.0, start2: 0.0, stop2: 100.0)
        print("v = \(v)")
        let v1 = TVector2(x: 1, y: 2)
        let v2 = v1 * 2.0
        print("v2 = \(v2.x),\(v2.y)")
        
        font = TFont(fontName: "Helvetica Neue Medium", ofSize: 32.0)
    }
    
    override func update() {
        
        background(red: 0.5, green: 0.5, blue: 0.5)
        
        lineWidth(2.0)
        
        fillColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0)
        strokeColor(red: 0.1, green: 0.05, blue: 0.05, alpha: 1.0)
        
        rect(x: tin.midX - 50.0, y: tin.midY - 50.0, width: 100.0, height: 100.0)
        
        
        rect(x: 5, y: 5, width: 15, height: 15)
        
        rect(x: 1000.0, y: 10.0, width: 30.0, height: 100.0)
        rect(x: 1050.0, y: 10.0, width: 30.0, height: 100.0)
        rect(x: tin.midX - 25.0, y: tin.midY - 25.0, width: 50.0, height: 50.0)
        
        if tin.mousePressed {
            fillDisable()
        }
        else {
            fillColor(red: 0.6, green: 0.1, blue: 0.2, alpha: 1.0)
        }
        ellipse(centerX: tin.midX, centerY: tin.midY + 125.0, width: 100.0, height: 100.0)
        
        lineWidth(5.0)
        line(x1: tin.midX - 400.0, y1: tin.midY - 100.0, x2: tin.midX + 400.0, y2: tin.midY - 100)
        
        
        lineWidth(2.0)
        fillColor(color: NSColor(red: 0.3, green: 0.2, blue: 0.8, alpha: 1.0))
        strokeEnable()
        triangle(x1: tin.midX, y1: tin.height - 20.0, x2: tin.midX - 50.0, y2: tin.height - 100.0, x3: tin.midX + 50.0, y3: tin.height - 100.0)
        
        lineWidth(3.0)
        strokeEnable()
        fillEnable()
        pathBegin()
        pathVertex(x: 50.0, y: 50.0)
        pathVertex(x: 125.0, y: 100.0)
        pathVertex(x: 50.0, y: 150.0)
        pathClose()
        pathEnd()
        
        fillDisable()
        lineWidth(15.0)
        pathBegin()
        pathVertex(x: 150.0, y: 50.0)
        pathAddCurve(to: CGPoint(x: 300.0, y: 180.0), control1: CGPoint(x: 230.0, y: 50.0), control2: CGPoint(x: 300.0, y: 100.0))
        pathEnd()
        
        lineWidth(2)
        strokeColor(gray: 0.0)
        fillColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0)
        arc(x: 50.0, y: tin.height - 200.0, radius: 75, startAngle: -.pi/4, endAngle: .pi/4)
        
        
        setAlpha(1.0)
        image(image: snowman!, x: 800.0, y: 300.0)
        setAlpha(1.0)
        image(image: logo!, x: 200.0, y: 300.0)
        
        setAlpha(0.5)
        if let f = font {
            fillColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            f.horizontalAlignment = .center
            f.verticalAlignment = .baseline
            f.lineHeightMultiple = 1.0
            f.paragraphAlignment = .center
            f.kerning = 0.0
            text(message: "Tin", font: f, x: tin.midX, y: 50.0)
            
            setAlpha(1.0)
            let rect = NSRect(x: tin.midX - 200.0, y: 20.0, width: 400.0, height: 90.0)
            fillDisable()
            strokeColor(gray: 0.05)
            roundedRect(rect: rect, xRadius: 5.0, yRadius: 5.0)
        }
        
        //stopUpdates()
        
    }

}
