//
//  TRandom.swift
//  Tin
//
//  Created by Loren Olson on 11/3/16.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Foundation
import GameplayKit

public struct TRandom {
    static let randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    
    /// return a random Double in the range [0.0, 1.0].
    public static func next(max: Double) -> Double {
        return Double(self.randomSource.nextUniform()) * max
    }
    
    /// return a random Double in the range [min, max].
    public static func next(min: Double, max: Double) -> Double {
        let distance = max - min
        return min + Double(self.randomSource.nextUniform()) * distance
    }
    
}
