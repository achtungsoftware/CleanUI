//
//  ChatTextFieldStyle.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// ChatTextFieldStyle: TextFieldStyle
public struct ChatTextFieldStyle: TextFieldStyle {
    
    var backgroundColor: Color
    
    /// - Parameter backgroundColor: The background color, default is `Color.background
    public init(backgroundColor: Color = Color.background) {
        self.backgroundColor = backgroundColor
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .font(.callout)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(backgroundColor)
                    .foregroundColor(Color.defaultText)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.defaultBorder, lineWidth: 0.4)
            )
    }
}
