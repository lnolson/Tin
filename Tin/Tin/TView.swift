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
    
    
    
    // MARK: - initializers
    
    
    public override init(frame frameRect: NSRect) {
        //debug("init(frame)")
        super.init(frame: frameRect)
    }
    
    public required init?(coder: NSCoder) {
        //debug("init?(coder:)")
        super.init(coder: coder)
    }
    
    public init(width: CGFloat, height: CGFloat) {
        let newFrame = NSRect(x: 0.0, y: 0.0, width: width, height: height)
        super.init(frame: newFrame)
    }
    
    
    // MARK: - instance methods
    
    
    open func setup() {
        // This space intentionally left blank
        // setup() is intended to be overridden by the user.
        // An opportunity for one time init for the view.
        // Do not put drawing code in setup. The view isn't ready for drawing yet.
        // It is a good time to init data.
    }
    
    
    func updateView() {
        needsDisplay = true
    }
    
    
    open func update() {
        // This space intentionally left blank
        // update() is intended to be overridden by the user.
        // Drawing code show go in update, or methods called during update.
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
        
        update()
        
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
            tin.setFillColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            infoFont.horizontalAlignment = .right
            tin.text(message: statsString, font: infoFont, x: frame.width - 5, y: 5)
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
        tin.resetSize(width: frame.width, height: frame.height)
        setup()
        tin.prepare(frame: frame)
        startUpdateTimer()
    }
    
    
    // MARK: - NSResponder
    
    
    open override var acceptsFirstResponder: Bool {
        return true
    }
    
    
    // Idea. Don't have students override these NSResponder methods.
    // During early part of introductory class, I don't want to deal with
    // complexity of overriding functions, and needing to call the super.
    // Provide another method for implentation in subclasses, which never
    // requires call to super. 
    // Should the names be very different to avoid confusion? Neet to consider.
    open override func keyDown(with event: NSEvent) {
        self.event = event
        keyDown()
    }
    
    
    open override func keyUp(with event: NSEvent) {
        self.event = event
        keyUp()
    }
    
    
    open override func mouseDown(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        self.event = event
        mouseDown()
    }
    
    
    open override func mouseDragged(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        self.event = event
        mouseDragged()
    }
    
    
    open override func mouseMoved(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        self.event = event
        mouseMoved()
    }
    
    
    open override func mouseUp(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        self.event = event
        mouseUp()
    }
    
    
    
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
