//
//  RoundedButtonStyle.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// RoundedButtonStyle: ButtonStyle
public struct RoundedButtonStyle: ButtonStyle {
    
    var buttonTheme: PrimaryButtonTheme
    var withOpacity: Bool
    
    /// - Parameters:
    ///   - buttonTheme: The button theme, default is `.primary
    ///   - withOpacity: Should the button background have a fixed opacity? Default is `false`
    public init(buttonTheme: PrimaryButtonTheme = .primary, withOpacity: Bool = false){
        self.buttonTheme = buttonTheme
        self.withOpacity = withOpacity
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(14)
            .font(.body.bold())
            .frame(maxWidth: .infinity)
            .if(buttonTheme == .primary || buttonTheme == .staticDark || buttonTheme == .staticLight || buttonTheme == .secondary){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .fill(buttonTheme == .primary ? Color.primaryColor : buttonTheme == .staticDark ? Color.accentStaticDark : buttonTheme == .secondary ? Color.accent2 : Color.white)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(buttonTheme == .imageOverlay){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .fill(.regularMaterial)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(buttonTheme == .materialDark || buttonTheme == .materialLight){ view in
                view
                    .background(
                        CLBlurView(buttonTheme == .materialDark ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight)
                            .cornerRadius(26)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .shadow(color: Color.black.opacity(0.04), radius: 8)
            .foregroundColor(buttonTheme == .primary ? .white : buttonTheme == .staticDark || buttonTheme == .materialDark ? Color.white : buttonTheme == .secondary ? Color.defaultText: Color.black)
            .scaleEffect(configuration.isPressed ? 0.97: 1)
    }
}
