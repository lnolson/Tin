//
//  TController.swift
//  Tin
//
//  Created by Loren Olson on 5/15/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa



open class TController: NSViewController, TViewDelegate {
    
    
    
    open override func viewWillAppear() {
        if let window = view.window {
            window.acceptsMouseMovedEvents = true
        }
        else {
            debug("window is nil")
        }
    }
    

    
    // move the window to the top, left corner of the current screen
    public func setWindowTopLeft() {
        if let visibleFrame = view.window?.screen?.visibleFrame {
            view.window?.setFrameTopLeftPoint(NSPoint(x: visibleFrame.origin.x, y: visibleFrame.origin.y + visibleFrame.size.height))
        }
    }
    
    
    // center the window in the current screen
    public func setWindowCentered() {
        if let visibleFrame = view.window?.screen?.visibleFrame {
            let x = visibleFrame.origin.x + (visibleFrame.size.width - view.frame.size.width) / 2.0
            let y = visibleFrame.origin.y + (visibleFrame.size.height - view.frame.size.height) / 2.0
            let newWinFrame = NSRect(x: x, y: y, width: view.frame.size.width, height: view.frame.size.height)
            view.window?.setFrame(newWinFrame, display: true)
        }
    }

    
    
    public func createView<T>(width: Double, height: Double, type: T.Type) where T: TView {
        let tinView = T(width: width, height: height)
        tinView.delegate = self
        view = tinView
    }
    
    
    public func createView(width: Double, height: Double) {
        let tinView = TView(width: width, height: height)
        tinView.delegate = self
        view = tinView
    }
    
    
    open func update() {
        // This space intentionally left blank
        // update() is intended to be overridden by the user.
        // Drawing code show go in update, or methods called during update.
    }
    
    
    
    // MARK: - NSResponder
    
    
    open override var acceptsFirstResponder: Bool {
        return true
    }
    
    
    open override func keyDown(with event: NSEvent) {
        //self.event = event
    }
    
    
    open override func keyUp(with event: NSEvent) {
        //self.event = event
    }
    
    
    open override func mouseDown(with event: NSEvent) {
        let point: CGPoint = view.convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        //self.event = event
    }
    
    
    open override func mouseDragged(with event: NSEvent) {
        let point: CGPoint = view.convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        //self.event = event
    }
    
    
    open override func mouseMoved(with event: NSEvent) {
        let point: CGPoint = view.convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        //self.event = event
    }
    
    
    open override func mouseUp(with event: NSEvent) {
        let point: CGPoint = view.convert(event.locationInWindow, from: nil)
        tin.mouseMoved(to: point)
        //self.event = event
    }

}


