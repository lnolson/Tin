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
    }
    
    
    func updateView() {
        needsDisplay = true
    }
    
    
    open func update() {
        // This space intentionally left blank
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
        var t = TStopwatch()
        t?.start()
        
        super.draw(dirtyRect)
        
        tin.updateFrameCount()
        
        tin.prepareForUpdate(frame: frame)
        
        update()
        
        if showStats {
            let averageDrawTime = totalDrawTime / TimeInterval(tin.frameCount - 1)
            tin.setFillColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            infoFont.horizontalAlignment = .right
            tin.text(message: String(format: "Draw %.04f", averageDrawTime), x: frame.width - 5, y: 5, font: infoFont)
        }
        
        tin.didFinishUpdate()
        
        if t != nil {
            let elapsed = t!.stop()
            totalDrawTime += elapsed
        }
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
        tin.prepare(frame: frame)
        setup()
        startUpdateTimer()
    }
    
    
    // MARK: - NSResponder
    
    
    open override var acceptsFirstResponder: Bool {
        return true
    }
    
    
    open override func keyDown(with event: NSEvent) {
        
    }
    
    open override func keyUp(with event: NSEvent) {
        
    }
    
    open override func mouseMoved(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
    }
    
    open override func mouseDragged(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
    }
    
    
    
    
    
    
}
