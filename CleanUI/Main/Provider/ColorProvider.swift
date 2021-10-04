//
//  ColorProvider.swift
//  CleanUI
//
//  Created by Julian Gerhards on 04.10.21.
//

import SwiftUI

/// Provides colors from the Asset Catalog
class ColorProvider {
    public static func color(_ named: String) -> Color {
        Color(UIColor(named: named, in: Bundle(for: self), compatibleWith: nil) ?? UIColor.white)
    }
    
    public static func uiColor(_ named: String) -> UIColor {
        UIColor(named: named, in: Bundle(for: self), compatibleWith: nil) ?? UIColor.white
    }
}
