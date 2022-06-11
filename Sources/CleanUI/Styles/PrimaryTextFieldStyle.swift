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
            .overlay(isTransparent ? RoundedRectangle(cornerRadius: 11).strokeBorder(Color.defaultBorder, lineWidth: 0.3) : nil)
    }
}

public extension TextFieldStyle where Self == PrimaryTextFieldStyle {
    
    static var knoggl: PrimaryTextFieldStyle {
        PrimaryTextFieldStyle()
    }
    
    static var knogglTransparent: PrimaryTextFieldStyle {
        PrimaryTextFieldStyle(isTransparent: true)
    }
}

struct PrimaryTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextField("Title", text: Binding.constant(""))
                .textFieldStyle(.knoggl)
                .padding()
            TextField("Title", text: Binding.constant(""))
                .textFieldStyle(.knogglTransparent)
                .padding()
        }
    }
}
