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

/// Returns a ``CLSingleLineTextEditor``. The editor is first single line and expands on line break
public struct CLSingleLineTextEditor: View {
    
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType
    var characterLimit: Int
    var attributes: [Attribute]
    
    @StateObject private var textViewStore = TextViewStore()
    
    /// - Parameters:
    ///   - text: The text to modify
    ///   - placeholder: The placeholder
    ///   - keyboardType: The keyboard type, default is `.twitter`
    ///   - characterLimit: The character limit which the user is allowed to type. 0 means no limit, default is `0`
    ///   - attributes: The attributes which should be highlighted, default is `[.links, .hashtags, .mentions]`
    public init(_ text: Binding<String>, placeholder: String = "", keyboardType: UIKeyboardType = .twitter, characterLimit: Int = 0, attributes: [Attribute] = [.links(), .hashtags(), .mentions()]){
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.characterLimit = characterLimit
        self.attributes = attributes
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            Text(text)
                .foregroundColor(Color.clear)
                .allowsHitTesting(false)
                .frame(minHeight: 0)
            
            if(text.isEmpty){
                Text(placeholder)
                    .foregroundColor(.gray)
                    .opacity(0.6)
                    .allowsHitTesting(false)
                    .lineLimit(1)
            }
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .overlay(
            TextViewOverlay(text: $text, font: .callout, maxLayoutWidth: UIScreen.main.bounds.size.width, textViewStore: textViewStore, keyboardType: keyboardType, isScrollEnabled: true, attributes: attributes)
        )
        .padding(10)
        .foregroundColor(Color.defaultText)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.defaultBorder, lineWidth: 0.4)
        )
        .onChange(of: text) { value in
            if characterLimit != 0 {
                if value.count > characterLimit {
                    DispatchQueue.main.async {
                        text = String(text.dropLast(value.count - characterLimit))
                    }
                }
            }
        }
    }
}
