//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// Returns a `Shape` with custom corner radius
public struct RoundedCorner: Shape {
    
    var radius: CGFloat
    var corners: UIRectCorner
    
    /// - Parameters:
    ///   - radius: The radius, default is `.infinity`
    ///   - corners: The corners which the radius should apply to, default is `.allCorners`
    public init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
