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

/// ImageOverlayButtonStyle: ButtonStyle
public struct ImageOverlayButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(Color.blackOpacity)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .foregroundColor(Color.white)
    }
}

struct ImageOverlayButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}){
            Text("Button")
        }
        .buttonStyle(ImageOverlayButtonStyle())
    }
}
