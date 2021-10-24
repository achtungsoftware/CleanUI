//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// PrimaryTextFieldStyle: TextFieldStyle
public struct PrimaryTextFieldStyle: TextFieldStyle {
    
    var isTransparent: Bool
    
    /// - Parameter isTransparent: When true, the TextField does have a clear background, default is `false
    public init(isTransparent: Bool = false) {
        self.isTransparent = isTransparent
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .font(.callout)
            .background(
                RoundedRectangle(cornerRadius: 11)
                    .fill(isTransparent ? .clear : Color.accent4)
                    .shadow(color: Color.black.opacity(0.02), radius: 8)
            )
            .if(isTransparent){ view in
                view
                    .overlay(
                        RoundedRectangle(cornerRadius: 11)
                            .strokeBorder(Color.defaultBorder, lineWidth: 0.4)
                    )
            }
    }
}
