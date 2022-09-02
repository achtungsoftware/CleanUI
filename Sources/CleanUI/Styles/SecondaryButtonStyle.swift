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

/// SecondaryButtonStyle: ButtonStyle
public struct SecondaryButtonStyle: ButtonStyle {
    
    var size: Size
    var style: Style
    
    public init(size: Size = .normal, style: Style = .normal){
        self.size = size
        self.style = style
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .lineLimit(1)
            .font(size == .normal ? .subheadline.weight(.medium) : .footnote)
            .padding(.horizontal, size == .normal ? 13.0 : 8)
            .padding(.vertical, 6.0)
            .foregroundColor(style == .normal ? .white : Color.primaryColor)
            .if(style == .normal) { view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryColor)
                    )
            }
            .if(style == .alternative) { view in
                view
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.accent3)
                    )
            }
            .scaleEffect(configuration.isPressed ? 0.95: 1)
    }
}

public extension SecondaryButtonStyle {
    enum Style {
        case normal
        case alternative
    }
    
    enum Size {
        case small
        case normal
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    
    static var knogglSecondary: SecondaryButtonStyle {
        SecondaryButtonStyle()
    }
    
    static var knogglSecondaryAlternative: SecondaryButtonStyle {
        SecondaryButtonStyle(style: .alternative)
    }
    
    static var knogglSecondarySmall: SecondaryButtonStyle {
        SecondaryButtonStyle(size: .small)
    }
    
    static var knogglSecondaryAlternativeSmall: SecondaryButtonStyle {
        SecondaryButtonStyle(size: .small, style: .alternative)
    }
}

struct SecondaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack {
                Button(action: {}) {
                    Text("Button")
                }
                .buttonStyle(.knogglSecondary)
                
                Button(action: {}) {
                    Text("Button")
                }
                .buttonStyle(.knogglSecondarySmall)
            }
            
            VStack {
                Button(action: {}) {
                    Text("Button")
                }
                .buttonStyle(.knogglSecondaryAlternative)
                
                Button(action: {}) {
                    Text("Button")
                }
                .buttonStyle(.knogglSecondaryAlternativeSmall)
            }
        }
    }
}
