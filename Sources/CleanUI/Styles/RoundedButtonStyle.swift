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

/// RoundedButtonStyle: ButtonStyle
public struct RoundedButtonStyle: ButtonStyle {
    
    var style: PrimaryButtonStyle.Style
    var withOpacity: Bool
    
    /// - Parameters:
    ///   - style: The button style, default is `.primary
    ///   - withOpacity: Should the button background have a fixed opacity? Default is `false`
    public init(style: PrimaryButtonStyle.Style = .primary, withOpacity: Bool = false){
        self.style = style
        self.withOpacity = withOpacity
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(14)
            .font(.callout.bold())
            .frame(maxWidth: .infinity)
            .if(style == .primary || style == .staticDark || style == .staticLight || style == .secondary){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .fill(style == .primary ? Color.primaryColor : style == .staticDark ? Color.accentStaticDark : style == .secondary ? Color.accent3 : Color.white)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(style == .imageOverlay){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .fill(.regularMaterial)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(style == .materialDark || style == .materialLight){ view in
                view
                    .background(
                        CLBlurView(style == .materialDark ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight)
                            .cornerRadius(26)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .shadow(color: Color.black.opacity(0.04), radius: 8)
            .foregroundColor(style == .primary ? .white : style == .staticDark || style == .materialDark ? Color.white : style == .secondary ? Color.primaryColor : Color.black)
            .scaleEffect(configuration.isPressed ? 0.97: 1)
    }
}

public extension ButtonStyle where Self == RoundedButtonStyle {
    
    static var knogglRounded: RoundedButtonStyle {
        RoundedButtonStyle()
    }
    
    static var knogglRoundedAlternative: RoundedButtonStyle {
        RoundedButtonStyle(style: .secondary)
    }
}

struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(.knogglRounded)
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(RoundedButtonStyle(style: .imageOverlay))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(RoundedButtonStyle(style: .staticLight))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(RoundedButtonStyle(style: .staticDark))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(RoundedButtonStyle(style: .materialDark))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(RoundedButtonStyle(style: .materialLight))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(.knogglRoundedAlternative)
        }
        .padding()
    }
}
