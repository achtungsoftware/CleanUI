//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public extension Color {
    
    /// Allows creating a Color with hex value
    /// - Parameter hex: Hex color code
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    static var accent: Color {
        ColorProvider.color("Accent")
    }
    
    static var accent2: Color {
        ColorProvider.color("Accent2")
    }
    
    static var accent3: Color {
        ColorProvider.color("Accent3")
    }
    
    static var accent4: Color {
        ColorProvider.color("Accent4")
    }
    
    static var defaultText: Color {
        ColorProvider.color("DefaultText")
    }
    
    static var grayText: Color {
        ColorProvider.color("GrayText")
    }
    
    static var link: Color {
        ColorProvider.color("Link")
    }
    
    static var defaultRed: Color {
        ColorProvider.color("DefaultRed")
    }
    
    static var background: Color {
        ColorProvider.color("Background")
    }
    
    static var primaryColor: Color {
        ColorProvider.color("Primary")
    }
    
    static var accentStaticDark: Color {
        ColorProvider.color("AccentStaticDark")
    }
    
    static var defaultBorder: Color {
        ColorProvider.color("DefaultBorder")
    }
    
    static var alert: Color {
        ColorProvider.color("Alert")
    }
}
