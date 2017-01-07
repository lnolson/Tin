//
//  TRandom.swift
//  Tin
//
//  Created by Loren Olson on 11/3/16.
//  Copyright © 2016 ASU. All rights reserved.
//

import Foundation
import GameplayKit

public struct TRandom {
    static let randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    
    public static func next( max: CGFloat ) -> (CGFloat) {
        return CGFloat(self.randomSource.nextUniform()) * max
    }
    
    public static func next( min: CGFloat, max: CGFloat) -> (CGFloat) {
        let distance = max - min
        return min + CGFloat(self.randomSource.nextUniform()) * distance
    }
    
}
