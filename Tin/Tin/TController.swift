//
//  TController.swift
//  Tin
//
//  Created by Loren Olson on 5/15/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa



open class TController: NSViewController {
    
    
    open var tinView: TView = TView(width: 500.0, height: 500.0)
    
    // TODO: This name is highly suspect. What would be better?
    public var tview: TView {
        return view as! TView
    }
    
//    override open var view: NSView {
//        get {
//            print("get view")
//            return tinView
//        }
//        set {
//            print("set view")
//            if newValue is TView {
//                print("set tinView using newValue")
//                tinView = newValue as! TView
//            }
//            else {
//                print("Warning, incorrect view type")
//            }
//        }
//    }
    
    
    open override func viewWillAppear() {
        if let window = view.window {
            window.acceptsMouseMovedEvents = true
        }
        else {
            error("window is nil.")
        }
    }
    

    
    /// move the window to the top, left corner of the current screen
    public func moveWindowToTopLeft() {
        if let visibleFrame = view.window?.screen?.visibleFrame {
            view.window?.setFrameTopLeftPoint(NSPoint(x: visibleFrame.origin.x, y: visibleFrame.origin.y + visibleFrame.size.height))
        }
    }
    
    
    /// move the window to center it in the current screen
    public func moveWindowToCenter() {
        if let visibleFrame = view.window?.screen?.visibleFrame {
            let x = visibleFrame.origin.x + (visibleFrame.size.width - view.frame.size.width) / 2.0
            let y = visibleFrame.origin.y + (visibleFrame.size.height - view.frame.size.height) / 2.0
            let newWinFrame = NSRect(x: x, y: y, width: view.frame.size.width, height: view.frame.size.height)
            view.window?.setFrame(newWinFrame, display: true)
        }
    }

    
    
    
    
    /// create a TView object and assign to the view property
    public func makeView(width: Double, height: Double) {
        view = TView(width: width, height: height)
    }
    
    
    /// make scene be the current TScene that is displayed by this TController.
    public func present(scene: TScene) {
        let tv = view as! TView
        tv.present(scene: scene)
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


