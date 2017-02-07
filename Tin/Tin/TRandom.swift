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
    
    public static func next<T>( max: T ) -> (T) where T: BinaryFloatingPoint {
        return T(self.randomSource.nextUniform()) * max
    }
    
    public static func next<T>( min: T, max: T) -> (T) where T: BinaryFloatingPoint {
        let distance = max - min
        return min + T(self.randomSource.nextUniform()) * distance
    }
    
}
