//
//  DateAndTime.swift
//  Tin
//
//  Created by Loren Olson on 1/3/17.
//  Copyright © 2017 ASU. All rights reserved.
//

//  Global functions for simple date and time calculations.

import Cocoa


public func year() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.year, from: date)
}


public func month() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.month, from: date)
}


public func day() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.day, from: date)
}


public func hour() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.hour, from: date)
}


public func minute() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.minute, from: date)
}


public func second() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.second, from: date)
}


public func nanosecond() -> Int {
    let date = Date()
    let calendar = Calendar.current
    return calendar.component(.nanosecond, from: date)
}


public func millis() -> Int {
    let date = Date()
    return Int(date.timeIntervalSince1970 * 1000.0)
}
