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
    var width: CGFloat
    var height: CGFloat
    
    
    init(image: CGImage) {
        cgimage = image
        width = CGFloat(image.width)
        height = CGFloat(image.height)
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
}
