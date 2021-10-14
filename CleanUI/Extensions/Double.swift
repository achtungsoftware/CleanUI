//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

public extension Double {
    
    /// Rounds a Double
    /// - Parameter places: To how many places after the comma should be rounded?
    /// - Returns: The rounded Double
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
