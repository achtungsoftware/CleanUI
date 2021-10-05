//
//  IconRoundOverImageButtonStyle.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// IconRoundOverImageButtonStyle: ButtonStyle
public struct IconRoundOverImageButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .frame(width: 28, height: 28)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(Color.black.opacity(0.75))
            )
    }
}

