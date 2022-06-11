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

/// Adds a ``CLCard`` style to a view without wrapping it inside a container
public struct CLCard<Content: View>: View {
    
    var content: () -> Content
    var accent2: Bool
    
    public init(accent2: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.accent2 = accent2
        self.content = content
    }
    
    public var body: some View {
        content()
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(RoundedRectangle(cornerRadius: 10).fill(accent2 ? Color.accent2 : Color.accent))
    }
}

struct CLCard_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CLCard {
                Text("Test")
            }
            
            CLCard(accent2: true) {
                Text("Test1")
            }
        }
        .listStyle(.plain)
    }
}
