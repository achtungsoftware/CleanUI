//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import Combine

/// PrimaryButtonStyle: ButtonStyle
public struct PrimaryButtonStyle: ButtonStyle {

    
    var buttonTheme: PrimaryButtonTheme
    var withOpacity: Bool
    
    /// - Parameters:
    ///   - buttonTheme: The button theme, default is `.primary`
    ///   - withOpacity: Should the button background have a fixed opacity? Default is false`
    public init(buttonTheme: PrimaryButtonTheme = .primary, withOpacity: Bool = false){
        self.buttonTheme = buttonTheme
        self.withOpacity = withOpacity
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12)
            .font(.callout)
            .frame(maxWidth: .infinity)
            .if(buttonTheme == .primary || buttonTheme == .staticDark || buttonTheme == .staticLight || buttonTheme == .secondary){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(buttonTheme == .primary ? Color.primaryColor : buttonTheme == .staticDark ? Color.accentStaticDark : buttonTheme == .secondary ? Color.accent3 : Color.white)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(buttonTheme == .imageOverlay){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.regularMaterial)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(buttonTheme == .materialDark || buttonTheme == .materialLight){ view in
                view
                    .background(
                        CLBlurView(buttonTheme == .materialDark ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight)
                            .cornerRadius(11)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .shadow(color: Color.black.opacity(0.04), radius: 8)
            .foregroundColor(buttonTheme == .primary ? .white : buttonTheme == .staticDark || buttonTheme == .materialDark ? Color.white : buttonTheme == .secondary ? Color.defaultText: Color.black)
            .scaleEffect(configuration.isPressed ? 0.97: 1)
    }
}
