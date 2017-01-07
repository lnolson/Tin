//
//  TStopwatch.swift
//  Tin
//
//  Created by Loren Olson on 1/5/17.
//  Copyright © 2017 ASU. All rights reserved.
//



import Foundation

/**
  A struct for simple timing.
  Uses mach_absolute_time for reliable, fine-grained timing.
 */
struct TStopwatch {
    
    var info = mach_timebase_info()
    var startTime: UInt64 = 0
    var endTime: UInt64 = 0
    var elapsed: UInt64 = 0
    
    
    init?() {
        guard mach_timebase_info(&info) == KERN_SUCCESS else { return nil }
    }
    
    
    mutating func start() {
        startTime = mach_absolute_time()
    }
    
    
    mutating func stop() -> TimeInterval {
        endTime = mach_absolute_time()
        elapsed = endTime - startTime
        
        let nanoSeconds = elapsed * UInt64(info.numer) / UInt64(info.denom)
        return TimeInterval(nanoSeconds) / TimeInterval(NSEC_PER_SEC)
    }
    
}
