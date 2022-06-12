//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
    
    static var accent5: Color {
        ColorProvider.color("Accent5")
    }
    
    static var defaultText: Color {
        ColorProvider.color("DefaultText")
    }
    
    static var grayText: Color {
        ColorProvider.color("GrayText")
    }
    
    static var defaultLink: Color {
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
    
    static var blackOpacity: Color {
        Color.black.opacity(0.45)
    }
}
