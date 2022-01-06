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
