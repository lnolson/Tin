//
//  SimpleLog.swift
//  Tin
//
//  Created by Loren Olson on 1/4/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation


// This is a very simple approach, and we may want to change to a more sophisitcated logging system in
// the future. Something someone else has already published.



/**
 Print a string to the console, marked as debug. This should be for debugging/development purposes only.
 TBD - In the future I will change this to only print in debug builds.
 Prepends file, function name and line number to message.
 
 - Parameter message: 
 
 */
public func debug(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    
    let fileURL = URL(fileURLWithPath: file).lastPathComponent
    print("DEBUG \(fileURL) \(function)[\(line)]: " + message)
}



/**
 Print a string to the console, marked as an error. This should be for debugging/development purposes only.
 Prepends file, function name and line number to message. Don't use this as a message to a typical user. Its
 for programmers writing code.
 
 - Parameter message:
 
 */
public func error(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    
    let fileURL = URL(fileURLWithPath: file).lastPathComponent
    print("ERROR \(fileURL) \(function)[\(line)]: " + message)
}
