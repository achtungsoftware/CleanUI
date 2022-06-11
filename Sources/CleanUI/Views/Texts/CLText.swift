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

public struct CLText: View {
    
    var text: String
    var type: TextType
    
    public init(_ text: String, type: TextType = .body) {
        self.text = text
        self.type = type
    }
    
    public var body: some View {
        Group {
            switch type {
            case .name:
                Text(text)
                    .font(.callout)
                    .fontWeight(.medium)
            case .body:
                Text(text)
                    .font(.callout)
            case .sub:
                Text(text)
                    .font(.subheadline)
            case .tiny:
                Text(text)
                    .font(.caption)
                    .foregroundColor(Color.grayText)
            }
        }
        .foregroundColor(Color.defaultText)
    }
}

public extension CLText {
    enum TextType {
        case name
        case body
        case sub
        case tiny
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 30) {
            CLText("This is a CLText")
            CLText("This is a CLText .body", type: .body)
            CLText("This is a CLText .name", type: .name)
            CLText("This is a CLText .sub", type: .sub)
            CLText("This is a CLText .tiny", type: .tiny)
        }
    }
}
