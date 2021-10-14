//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// Provides colors from the CleanUI frameworks Asset Catalog
class ColorProvider {
    
    /// Gets a color from the asset catalog
    /// - Parameter named: The color name
    /// - Returns: Color
    public static func color(_ named: String) -> Color {
        Color(UIColor(named: named, in: Bundle(for: self), compatibleWith: nil) ?? UIColor.white)
    }
    
    /// Gets a color from the asset catalog
    /// - Parameter named: The color name
    /// - Returns: UIColor
    public static func uiColor(_ named: String) -> UIColor {
        UIColor(named: named, in: Bundle(for: self), compatibleWith: nil) ?? UIColor.white
    }
}
