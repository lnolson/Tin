//
//  TImage.swift
//  Tin
//
//  Created by Loren Olson on 1/3/17.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Cocoa





open class TImage: NSObject {

    
    var cgimage: CGImage?
    public var width: CGFloat
    public var height: CGFloat
    public var pixels: [UInt8]?
    
    
    init(image: CGImage) {
        cgimage = image
        width = CGFloat(image.width)
        height = CGFloat(image.height)
        pixels = nil
        super.init()
    }
    
    
    
    public class func makeImage(imageFile: String) -> TImage? {
        if FileManager.default.fileExists(atPath: imageFile) == false {
            error("File does not exist. \(imageFile)")
            return nil
        }
        var image: CGImage?
        if let dataProvider = CGDataProvider(filename: imageFile.cString(using: .utf8)!) {
            if let imageExtension = NSURL(fileURLWithPath: imageFile).pathExtension?.lowercased() {
                if imageExtension == "jpg" || imageExtension == "jpeg" {
                    image = CGImage(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
                }
                else if imageExtension == "png" {
                    image = CGImage(pngDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
                }
            }
        }
        
        if image != nil {
            return TImage(image: image!)
        }
        else {
            return nil
        }
    }
    
    
    public class func makeImage(imageFileInBundle: String) -> TImage? {
        let bundle = Bundle.main
        let imagePath = bundle.resourcePath! + "/" + imageFileInBundle
        return self.makeImage(imageFile: imagePath)
    }
    
    
    public func loadPixels() {
        if let image = self.cgimage {
            let w = Int(width)
            let h = Int(height)
            let dataSize = w * h * 4
            var pixelData = [UInt8](repeating: 0, count: dataSize)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: &pixelData,
                                    width: w,
                                    height: h,
                                    bitsPerComponent: 8,
                                    bytesPerRow: 4 * w,
                                    space: colorSpace,
                                    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
            
            // The context must be flipped in the Y axis.
            // Otherwise, origin will be top, left.
            context?.translateBy(x: 0, y: height)
            context?.scaleBy(x: 1.0, y: -1.0)
            
            context?.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            pixels = pixelData
        }
    }
    
    
    public func pixel(at point: CGPoint) -> TPixel {
        return pixel(atX: Int(point.x), y: Int(point.y))
    }
    
    
    public func pixel(atX x: Int, y: Int) -> TPixel {
        if pixels == nil {
            return TPixel(red: 0, green: 0, blue: 0, alpha: 0)
        }
        if x < 0 || x > Int(width) || y < 0 || y > Int(height) {
            return TPixel(red: 0, green: 0, blue: 0, alpha: 0)
        }
        let loc = Int(width) * 4 * y + (x * 4)
        return TPixel(red: pixels![loc], green: pixels![loc+1], blue: pixels![loc+2], alpha: pixels![loc+3])
    }
    
    
    public func color(atX x: Int, y: Int) -> TColor {
        return TColor(pixel: pixel(atX: x, y: y) )
    }
}
