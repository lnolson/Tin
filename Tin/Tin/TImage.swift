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
    public var width: Double
    public var height: Double
    public var pixels: [UInt8]?
    var cglayer: CGLayer?
    
    
    public init(image: CGImage) {
        cgimage = image
        width = Double(image.width)
        height = Double(image.height)
        pixels = nil
        super.init()
    }
    
    
    public convenience init?(contentsOfFile filename: String) {
        if FileManager.default.fileExists(atPath: filename) == false {
            error("File does not exist. \(filename)")
            return nil
        }
        var image: CGImage?
        if let dataProvider = CGDataProvider(filename: filename.cString(using: .utf8)!) {
            if let imageExtension = NSURL(fileURLWithPath: filename).pathExtension?.lowercased() {
                if imageExtension == "jpg" || imageExtension == "jpeg" {
                    image = CGImage(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
                }
                else if imageExtension == "png" {
                    image = CGImage(pngDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
                }
                else {
                    print("Image file must be in jpeg or png format.")
                }
            }
        }
        
        if let cgimage = image {
            self.init(image: cgimage)
        }
        else {
            return nil
        }
    }
    
    
    public convenience init?(contentsOfFileInBundle filename: String) {
        let bundle = Bundle.main
        if let bundleResourcePath = bundle.resourcePath {
            let imagePath = bundleResourcePath + "/" + filename
            self.init(contentsOfFile: imagePath)
        }
        else {
            self.init(contentsOfFile: filename)
        }
    }
    
    
    // Create a CGLayer, then draw the image into the CGLayer.
    // The CGLayer will be used to actually draw the image.
    func createLayer(cg: CGContext, width: Double, height: Double) {
        cglayer = CGLayer(cg, size: CGSize(width: width, height: height), auxiliaryInfo: nil)
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        if let cgimage = cgimage, let cglayer = cglayer, let ctx = cglayer.context {
            ctx.draw(cgimage, in: rect)
        }
    }
    
    
    public func loadPixels() {
        if let image = self.cgimage {
            let w = Int(width)
            let h = Int(height)
            let dataSize = w * h * 4
            var pixelData = [UInt8](repeating: 0, count: dataSize)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            if let context = CGContext(data: &pixelData,
                                    width: w,
                                    height: h,
                                    bitsPerComponent: 8,
                                    bytesPerRow: 4 * w,
                                    space: colorSpace,
                                    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) {
                context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            }
            pixels = pixelData
        }
    }
    
    
    public func savePixels() {
        if pixels == nil {
            print("savePixels failed, pixels buffer is nil.")
            return
        }
        let bitmapCount: Int = pixels!.count
        let elementLength: Int = MemoryLayout<TPixel>.size
        let intent: CGColorRenderingIntent = CGColorRenderingIntent.defaultIntent
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let data = NSData(bytes: pixels, length: bitmapCount)
        guard let providerRef = CGDataProvider(data: data) else {
            print("savePixels failed, CGDataProvider returned nil")
            return
        }
        
        let w = Int(width)
        let h = Int(height)
        guard let newimage = CGImage(width: w, height: h, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: w * elementLength, space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: providerRef, decode: nil, shouldInterpolate: true, intent: intent) else {
            debug("Error in savePixels: CGImage returned nil")
            return
        }
        
        cgimage = newimage
    }
    
    
    public func pixel(at point: CGPoint) -> TPixel {
        return pixel(atX: Int(point.x), y: Int(point.y))
    }
    
    
    public func pixel(atX x: Int, y: Int) -> TPixel {
        if pixels == nil {
            return TPixel(red: 0, green: 0, blue: 0, alpha: 0)
        }
        if x < 0 || x >= Int(width) || y < 0 || y >= Int(height) {
            return TPixel(red: 0, green: 0, blue: 0, alpha: 0)
        }
        
        let flippedY = (y * -1) + Int(height) - 1
        let loc = Int(width) * 4 * flippedY + (x * 4)
        return TPixel(red: pixels![loc], green: pixels![loc+1], blue: pixels![loc+2], alpha: pixels![loc+3])
    }
    
    
    public func color(atX x: Int, y: Int) -> TColor {
        return TColor(pixel: pixel(atX: x, y: y) )
    }
    
    
    public func set(pixel: TPixel, x: Int, y: Int) {
        if x < 0 || x > Int(width) || y < 0 || y > Int(height) {
            print("Timage set(pixel:,x:\(x),y:\(y) out of range")
            return
        }
        if pixels == nil {
            print("TImage set(pixel:,x:,y:), pixels buffer is nil.")
            return
        }
        
        let flippedY = (y * -1) + Int(height) - 1
        let loc = Int(width) * 4 * flippedY + (x * 4)
        
        pixels![loc] = pixel.red
        pixels![loc+1] = pixel.green
        pixels![loc+2] = pixel.blue
        pixels![loc+3] = pixel.alpha
    }
    
    //func image(image: TImage, x: Double, y: Double)
    //func image(image: TImage, x: Double, y: Double, width: Double, height: Double)
    public func draw(x: Double, y: Double) {
        image(image: self, x: x, y: y)
    }
    
    
    public func draw(x: Double, y: Double, width: Double, height: Double) {
        image(image: self, x: x, y: y, width: width, height: height)
    }
}
