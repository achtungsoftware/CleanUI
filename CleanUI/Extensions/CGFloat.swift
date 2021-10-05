//
//  CGFloat.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

public extension CGFloat {
    
    
    /// Clamps a CGFloat to a max value
    /// - Parameter max: The maximal allowed value for this CGFloat
    /// - Returns: The CGFloat with the specified maximum value
    func maxValue(_ max: CGFloat) -> CGFloat {
        if(self > max) {
            return max
        }else {
            return self
        }
    }
    
    /// Clamps a CGFloat to a min value
    /// - Parameter min: The minimal allowed value for this CGFloat
    /// - Returns: The CGFloat with the specified minimum value
    func minValue(_ min: CGFloat) -> CGFloat {
        if(self < min) {
            return min
        }else {
            return self
        }
    }
}
