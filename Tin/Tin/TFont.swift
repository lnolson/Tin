//
//  TFont.swift
//  Tin
//
//  Created by Loren Olson on 1/4/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Cocoa


public enum TinFontHorizontalAlignment {
    case left
    case center
    case right
}


public enum TinFontVerticalAlignment {
    case bottom
    case baseline
    case center
    case top
}


open class TFont {
    
    var font: NSFont
    public var horizontalAlignment: TinFontHorizontalAlignment = .center
    public var verticalAlignment: TinFontVerticalAlignment = .baseline
    public var lineHeightMultiple: CGFloat = 1.0
    public var paragraphAlignment: NSTextAlignment = .left
    public var kerning: CGFloat = 0.0
    
    
    
    public init(fontName: String, ofSize size: CGFloat) {
        if let font = NSFont(name: fontName, size: size) {
            debug("font \(fontName) loaded.")
            self.font = font
        }
        else {
            error("Unable to initialize font \(fontName) @ \(size), using userFont")
            self.font = NSFont.userFont(ofSize: size)!
        }
    }
    
    
    
    func makeAttributes() -> [String : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = paragraphAlignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributes: [String : Any] = [
            NSForegroundColorAttributeName: tin.fillColor(),
            NSParagraphStyleAttributeName: paragraphStyle,
            NSKernAttributeName: kerning,
            NSFontAttributeName: font
        ]
        return attributes
    }
    
    
    
    public func size(ofMessage message: String) -> NSSize {
        let attributes = makeAttributes()
        let str: NSAttributedString = NSAttributedString(string: message, attributes: attributes)
        return str.size()
    }

}
