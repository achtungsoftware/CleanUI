//
//  ImageOverlayButtonStyle.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// ImageOverlayButtonStyle: ButtonStyle
public struct ImageOverlayButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(
                Color.black
                    .opacity(0.6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .foregroundColor(Color.white)
    }
}
