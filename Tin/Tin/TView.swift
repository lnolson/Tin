//
//  TView.swift
//  Tin
//
//  Created by Loren Olson on 12/28/16.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Cocoa


public protocol TViewDelegate {
    
    func update()
    
}

    

open class TView: NSView {
    
    
    // MARK: - properties
    
    public var frameRate = 60.0 {
        didSet {
            if frameRate != oldValue {
                if timer != nil {
                    timer!.invalidate()
                }
                startUpdateTimer()
            }
        }
    }
    public var isRunning: Bool {
        return timer != nil
    }
    
    private var timer: Timer?
    private var totalDrawTime: TimeInterval = 0.0
    private var infoFont = TFont(fontName: "Courier New", ofSize: 14.0)
    public var showStats = true
    private var statsString = ""
    public var event: NSEvent = NSEvent()
    public var scene: TScene?
    
    
    
    // MARK: - initializers
    
    
    public override init(frame frameRect: NSRect) {
        //debug("init(frame)")
        super.init(frame: frameRect)
    }
    
    public required init?(coder: NSCoder) {
        //debug("init?(coder:)")
        super.init(coder: coder)
    }
    
    public required init(width: Double, height: Double) {
        let newFrame = NSRect(x: 0.0, y: 0.0, width: width, height: height)
        super.init(frame: newFrame)
    }
    
    
    // MARK: - instance methods
    
    
    
    public func present(scene: TScene) {
        self.scene = scene
        scene.view = self
    }
    
    
    public func stopUpdates() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    
    public func startUpdates() {
        if timer == nil {
            startUpdateTimer()
        }
    }
    
    
    private func startUpdateTimer() {
        debug("Start updates @ \(frameRate) fps")
        let interval = 1.0 / frameRate
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(TView.updateView), userInfo: nil, repeats: true)
    }
    
    
    // MARK: - NSView
    
    
    open override func draw(_ dirtyRect: NSRect) {
        let t = TStopwatch()
        
        super.draw(dirtyRect)
        
        
        tin.updateFrameCount()
        
        tin.prepareForUpdate(frame: frame)
        
        if let scene = scene {
            if scene.needsSetup {
                scene.setup()
                scene.needsSetup = false
            }
            scene.update()
        }
        
        if showStats {
            var elapsedTime: TimeInterval = 0.0
            if let t = t {
                elapsedTime = t.elapsedSeconds
                totalDrawTime += elapsedTime
            }
            if tin.frameCount % Int(frameRate) == 0 {
                let averageDrawTime = totalDrawTime / TimeInterval(tin.frameCount)
                statsString = String(format: "Draw %0.4f/%.04f", elapsedTime, averageDrawTime)
            }
            fillColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            infoFont.horizontalAlignment = .right
            text(message: statsString, font: infoFont, x: Double(frame.width) - 5.0, y: 5.0)
        }
        
        // All drawing operations need to happen before calling didFinishUpdate()
        tin.didFinishUpdate()
        
    }
    
    
    /*
     This might produce unexpected results if the user did something that caused this method to be called a second time.
     Should we do something to notice multiple calls?
     */
    open override func viewDidMoveToWindow() {
        window?.acceptsMouseMovedEvents = true
        let trackingRect = NSRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let trackingOptions: NSTrackingAreaOptions = [.activeAlways,.mouseMoved]
        let area = NSTrackingArea(rect: trackingRect, options: trackingOptions, owner: self, userInfo: nil)
        addTrackingArea(area)

        
        tin.makeRenderer()
        tin.resetSize(width: Double(frame.width), height: Double(frame.height))
        //setup()
        tin.prepare(frame: frame)
 
        
        startUpdateTimer()
    }
    
    
    func updateView() {
        needsDisplay = true
    }
    
    
    /*
    open func setup() {
        // This space intentionally left blank
        // setup() is intended to be overridden by the user.
        // An opportunity for one time init for the view.
        // Do not put drawing code in setup. The view isn't ready for drawing yet.
        // It is a good time to init data.
    }
    
    
    
    
    
    open func update() {
        // This space intentionally left blank
        // update() is intended to be overridden by the user.
        // Drawing code show go in update, or methods called during update.
    }
    */

    
    
    
        
}


/*

    
    
 
    
    
    
 
    
    
 
    
    
 
    
 
    
    
 
    
    
    // Idea. Don't have students override these NSResponder methods.
    // During early part of introductory class, I don't want to deal with
    // complexity of overriding functions, and needing to call the super.
    // Provide another method for implentation in subclasses, which never
    // requires call to super. 
    // Should the names be very different to avoid confusion? Neet to consider.
 
    
    
    
    // MARK: - Simplified override methods for events
    
    // Users should override these methods, not the NSResponder methods.
    
    open func keyDown() {
        
    }
    
    
    open func keyUp() {
        
    }
    
    
    open func mouseDown() {
        
    }
    
    
    open func mouseDragged() {
        
    }
    
    
    open func mouseMoved() {
        
    }
    
    
    open func mouseUp() {
        
    }
    
    
}
 
 */
