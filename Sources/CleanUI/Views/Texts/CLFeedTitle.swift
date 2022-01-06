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

/// Returns a ``CLFeedTitle`` for implementation in feeds or forms
public struct CLFeedTitle: View {
    
    var title: String
    var withMargin: Bool
    
    /// - Parameters:
    ///   - title: The title `String`
    ///   - withMargin: Should the default padding be applied? Default is `true
    public init(_ title: String, withMargin: Bool = true) {
        self.title = title
        self.withMargin = withMargin
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.defaultText)
                .textCase(.none)
            Spacer()
        }
        .if(withMargin, transform: { view in
            view
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 8)
        })
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
    }
}
