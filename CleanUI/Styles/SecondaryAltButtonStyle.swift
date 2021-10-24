//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public enum SecondaryButtonSize {
    case small
    case normal
}

/// SecondaryAltButtonStyle: ButtonStyle
public struct SecondaryAltButtonStyle: ButtonStyle {
    
    var translucent: Bool
    var size: SecondaryButtonSize
    
    /// - Parameter translucent: Should the button background have a fixed opacity? Default is `false
    /// - Parameter size: The button size, default is `.normal`
    public init(translucent: Bool = false, size: SecondaryButtonSize = .normal){
        self.translucent = translucent
        self.size = size
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(size == .normal ? .subheadline.weight(.medium) : .footnote)
            .padding(.horizontal, size == .normal ? 13.0 : 8)
            .padding(.vertical, 6.0)
            .if(translucent) { view in
                view.background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.thinMaterial)
                )
            }
            .if(!translucent) { view in
                view.background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.background)
                )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.defaultBorder, lineWidth: 0.4)
            )
            .scaledToFill()
            .foregroundColor(Color.defaultText)
            .scaleEffect(configuration.isPressed ? 0.95: 1)
    }
}
