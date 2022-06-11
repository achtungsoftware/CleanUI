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

public extension TextFieldStyle where Self == ChatTextFieldStyle {

    static var knogglChat: ChatTextFieldStyle {
        ChatTextFieldStyle()
    }
}

struct ChatTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Title", text: Binding.constant(""))
            .textFieldStyle(.knogglChat)
            .padding()
    }
}
