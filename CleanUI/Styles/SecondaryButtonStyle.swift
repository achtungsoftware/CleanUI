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

/// SecondaryButtonStyle: ButtonStyle
public struct SecondaryButtonStyle: ButtonStyle {
    
    var size: SecondaryButtonSize
    
    /// - Parameter size: The button size, default is `.normal
    public init(size: SecondaryButtonSize = .normal){
        self.size = size
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(size == .normal ? .subheadline.weight(.medium) : .footnote)
            .padding(.horizontal, size == .normal ? 13.0 : 8)
            .padding(.vertical, 6.0)
            .foregroundColor(.white)
            .if(colorScheme == .dark) { view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryColor)
                            .opacity(0.3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.primaryColor, lineWidth: 0.5)
                            .opacity(0.6)
                    )
            }
            .if(colorScheme != .dark) { view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryColor)
                    )
            }
            .scaledToFill()
            .scaleEffect(configuration.isPressed ? 0.95: 1)
    }
}
