//
//  ViewController.swift
//  ImageDemo
//
//  Created by Loren Olson on 3/9/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {

    
    var image: TImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewWillAppear() {
        
        createView(width: 1203.0, height: 800.0)
        
        
        image = TImage(contentsOfFileInBundle: "puffin.jpg")
        if let image = image {
            image.loadPixels()
        }
        
        let v = view as! TView
        v.frameRate = 60.0
        v.showStats = false
        
        tin.enableRestoreFromPrevious()
    }
    
    
    
    override func update() {
        //tin.background(red: 0.5, green: 0.1, blue: 0.1)
        if tin.frameCount == 1 {
            debug("clear")
            background(gray: 0.0)
        }
        abstractB()
        
    }
    
    
    func abstractB() {
        tin.stroke = false
        if image != nil {
            
            
            dropCircle2(x: 1203.0, y: 800.0)
            
            for _ in 0...100 {
                
                let x = TRandom.next(max: Double(tin.size.width))
                let y = TRandom.next(max: Double(tin.size.height))
                dropCircle2(x: x, y: y)
                
            }
            
        }
    }
    
    
    func dropCircle2(x: Double, y: Double) {
        var color = image!.color(atX: Int(x), y: Int(y))
        let luma = color.luminance()
        color.alpha = remap(value: luma, start1: 0.0, stop1: 1.0, start2: 0.01, stop2: 1.0)
        color.setFillColor()
        let w = remap(value: luma, start1: 0.0, stop1: 1.0, start2: 20.0, stop2: 4.0)
        ellipse(centerX: x, centerY: y, width: w, height: w)
    }
    
    
    
    func abstractA() {
        tin.stroke = false
        if image != nil {
            image!.loadPixels()
            
            for _ in 0...10 {
                let chance = TRandom.next(max: 1.0)
                if chance < 0.9 {
                    let x = TRandom.next(max: Double(tin.size.width))
                    let y = TRandom.next(max: Double(tin.size.height))
                    let w = TRandom.next(min: 4.0, max: 20.0)
                    dropCircle(x: x, y: y, w: w)
                }
            }
        }
    }
    
    
    func dropCircle(x: Double, y: Double, w: Double) {
        let color = image!.color(atX: Int(x), y: Int(y))
        color.setFillColor()
        ellipse(centerX: x, centerY: y, width: w, height: w)
    }
    
    
    func drawPixelsDemo() {
        if image != nil {
            image!.loadPixels()
            
            tin.stroke = false
            
            var y = 0.0
            while y < Double(image!.height) {
                var x = 0.0
                while x < Double(image!.width) {
                    
                    let c = image!.color(atX: Int(x), y: Int(y))
                    c.setFillColor()
                    
                    rect(x: x, y: y, width: 1.0, height: 1.0)
                    x += 1.0
                }
                y += 1.0
            }
        }
        
        let v = view as! TView
        v.stopUpdates()
    }

    

}

