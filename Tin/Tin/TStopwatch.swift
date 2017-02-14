//
//  TStopwatch.swift
//  Tin
//
//  Created by Loren Olson on 1/5/17.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//



import Foundation

/**
  A struct for simple timing.
  Uses mach_absolute_time for reliable, fine-grained timing.
 */
struct TStopwatch {
    
    var info = mach_timebase_info()
    var startTime: UInt64 = 0
    
    // This is the raw elapsed time value, but this value is CPU dependant!
    // See https://developer.apple.com/library/content/qa/qa1398/_index.html
    // Instead, user should use elapsedNanoSeconds or elapsedSeconds
    var elapsed: UInt64 {
        let currentTime = mach_absolute_time()
        return currentTime - startTime
    }
    
    var elapsedNanoSeconds: UInt64 {
        return elapsed * UInt64(info.numer) / UInt64(info.denom)
    }
    
    var elapsedSeconds: TimeInterval {
        return TimeInterval(elapsedNanoSeconds) / TimeInterval(NSEC_PER_SEC)
    }
    
    
    // The startTime is set on initialization
    init?() {
        guard mach_timebase_info(&info) == KERN_SUCCESS else { return nil }
        startTime = mach_absolute_time()
    }
    
    
    // Reset the startTime
    mutating func reset() {
        startTime = mach_absolute_time()
    }
    
    
}
