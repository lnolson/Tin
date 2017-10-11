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
    
    /// return a random Double in the range [0.0, max].
    public static func next(max: Double) -> Double {
        return Double(self.randomSource.nextUniform()) * max
    }
    
    /// return a random Double in the range [min, max].
    public static func next(min: Double, max: Double) -> Double {
        let distance = max - min
        return min + Double(self.randomSource.nextUniform()) * distance
    }
    
}


let tinRandomSource = GKLinearCongruentialRandomSource.sharedRandom()
let tinGaussianSource = GKGaussianDistribution(lowestValue: 0, highestValue: 10000)


public func random(max: Double) -> Double {
    return Double(tinRandomSource.nextUniform()) * max
}


public func random(min: Double, max: Double) -> Double {
    let distance = max - min
    return min + Double(tinRandomSource.nextUniform()) * distance
}


// Return a random value in a normal distribution, in the range -1 to 1.
// The mean value is 0. Deviation is 0.3334.
public func randomGaussian() -> Double {
    return (Double(tinGaussianSource.nextUniform()) * 2.0) - 1.0
}
