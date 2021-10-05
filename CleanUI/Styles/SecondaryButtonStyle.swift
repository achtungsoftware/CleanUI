//
//  SecondaryButtonStyle.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// SecondaryButtonStyle: ButtonStyle
public struct SecondaryButtonStyle: ButtonStyle {
    
    var size: SecondaryButtonSize
    
    /// - Parameter size: The button size, default is .normal
    public init(size: SecondaryButtonSize = .normal){
        self.size = size
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(size == .normal ? .subheadline.weight(.medium) : .footnote)
            .padding(.horizontal, size == .normal ? 13.0 : 8)
            .padding(.vertical, 6.0)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.primaryColor)
            )
            .scaledToFill()
            .scaleEffect(configuration.isPressed ? 0.95: 1)
    }
}
