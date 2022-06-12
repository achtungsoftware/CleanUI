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

/// PrimaryButtonStyle: ButtonStyle
public struct PrimaryButtonStyle: ButtonStyle {

    
    var style: Style
    var withOpacity: Bool
    
    /// - Parameters:
    ///   - style: The button style, default is `.primary`
    ///   - withOpacity: Should the button background have a fixed opacity? Default is false`
    public init(style: Style = .primary, withOpacity: Bool = false){
        self.style = style
        self.withOpacity = withOpacity
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12)
            .font(.callout.bold())
            .frame(maxWidth: .infinity)
            .if(style == .primary || style == .staticDark || style == .staticLight || style == .secondary || style == .secondary2){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(style == .primary ? Color.primaryColor : style == .staticDark ? Color.accentStaticDark : style == .secondary ? Color.accent3 : style == .secondary2 ? Color.accent5 : .white)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(style == .imageOverlay){ view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.regularMaterial)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .if(style == .materialDark || style == .materialLight){ view in
                view
                    .background(
                        CLBlurView(style == .materialDark ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight)
                            .cornerRadius(11)
                            .opacity(withOpacity ? 0.6 : 1)
                    )
            }
            .shadow(color: Color.black.opacity(0.04), radius: 8)
            .foregroundColor(style == .primary ? .white : style == .staticDark || style == .materialDark ? Color.white : style == .secondary || style == .secondary2 ? Color.primaryColor : Color.black)
            .scaleEffect(configuration.isPressed ? 0.97: 1)
    }
}

public extension PrimaryButtonStyle {
    enum Style {
        case primary
        case imageOverlay
        case staticLight
        case staticDark
        case materialDark
        case materialLight
        case secondary
        case secondary2
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    
    static var knoggl: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
    
    static var knogglAlternative: PrimaryButtonStyle {
        PrimaryButtonStyle(style: .secondary)
    }
    
    static var knogglAlternative2: PrimaryButtonStyle {
        PrimaryButtonStyle(style: .secondary2)
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(.knoggl)
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(PrimaryButtonStyle(style: .imageOverlay))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(PrimaryButtonStyle(style: .staticLight))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(PrimaryButtonStyle(style: .staticDark))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(PrimaryButtonStyle(style: .materialDark))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(PrimaryButtonStyle(style: .materialLight))
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(.knogglAlternative)
            
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(.knogglAlternative2)
        }
        .padding()
    }
}
