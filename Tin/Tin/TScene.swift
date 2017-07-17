//
//  TScene.swift
//  Tin
//
//  Created by Loren Olson on 5/30/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa



open class TScene {
    
    // MARK: - properties
    
    open var view: TView?
    var needsSetup = true
    
    
    // MARK: - initializers
    
    
    public init() {
        
    }
    
    
    // MARK: - instance methods
    
    
    open func setup() {
        // This space intentionally left blank
        // setup() is intended to be overridden by the user.
        // setup() is called one time, immediately before first call to update().
    }
    
    
    open func update() {
        // This space intentionally left blank
        // update() is intended to be overridden by the user.
        // Drawing code show go in update, or methods called during update.
    }
    
}
