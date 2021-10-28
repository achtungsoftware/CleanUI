//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// SecondaryButtonStyle: ButtonStyle
public struct SecondaryButtonStyle: ButtonStyle {
    
    var size: SecondaryButtonSize
    
    /// - Parameter size: The button size, default is `.normal
    public init(size: SecondaryButtonSize = .normal){
        self.size = size
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(size == .normal ? .subheadline.weight(.medium) : .footnote)
            .padding(.horizontal, size == .normal ? 13.0 : 8)
            .padding(.vertical, 6.0)
            .foregroundColor(.white)
            .if(colorScheme == .dark) { view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryColor)
                            .opacity(0.3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.primaryColor, lineWidth: 0.5)
                            .opacity(0.6)
                    )
            }
            .if(colorScheme != .dark) { view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryColor)
                    )
            }
            .scaledToFill()
            .scaleEffect(configuration.isPressed ? 0.95: 1)
    }
}
