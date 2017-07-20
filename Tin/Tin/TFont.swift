//
//  TFont.swift
//  Tin
//
//  Created by Loren Olson on 1/4/17.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
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
            //debug("font \(fontName) loaded.")
            self.font = font
        }
        else {
            error("Unable to initialize font \(fontName) @ \(size), using userFont")
            self.font = NSFont.userFont(ofSize: size)!
        }
    }
    
    
    
    func makeAttributes() -> [NSAttributedStringKey : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = paragraphAlignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor: fillColor(),
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.kern: kerning,
            NSAttributedStringKey.font: font
        ]
        return attributes
    }
    
    
    
    public func size(ofMessage message: String) -> NSSize {
        let attributes = makeAttributes()
        let str: NSAttributedString = NSAttributedString(string: message, attributes: attributes)
        return str.size()
    }

}
