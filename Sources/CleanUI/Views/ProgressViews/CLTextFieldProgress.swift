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

/// Returns a ``CLTextFieldProgress`` view for indication how much the user is allowed to type inside a TextField or TextEditor
public struct CLTextFieldProgress: View {
    
    @Binding var text: String
    var characterLimit: Int
    
    /// - Parameters:
    ///   - text: The binding text (String)
    ///   - characterLimit: The character limit
    public init(_ text: Binding<String>, characterLimit: Int) {
        self._text = text
        self.characterLimit = characterLimit
    }
    
    @State private var progress: Float = 0
    @State private var remainingCharacters: Int = 0
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2.0)
                .foregroundColor(Color.gray)
                .opacity(0.6)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 2.0))
                .foregroundColor(Color.primaryColor)
                .rotationEffect(Angle(degrees: 270.0))
            
            if remainingCharacters < 0 {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(Color.defaultRed)
                    Circle()
                        .fill(Color.defaultRed)
                }
            }
        }
        .frame(width: 22, height: 22)
        .onChange(of: text) { value in
            withAnimation {
                progress = Float(value.count) / Float(characterLimit)
                remainingCharacters = characterLimit - value.count
            }
        }
        .onLoad {
            remainingCharacters = characterLimit - text.count
        }
    }
}
