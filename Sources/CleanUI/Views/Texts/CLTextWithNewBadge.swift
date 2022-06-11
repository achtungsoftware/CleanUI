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

/// Returns a ``CLTextWithNewBadge`` (Text with optional ``CLNewBadge`)
public struct CLTextWithNewBadge: View {
    
    var string: String
    var newBadge: Bool
    
    /// - Parameters:
    ///   - string: The text String
    ///   - newBadge: Should a ``CLNewBadge`` be applied?
    public init(_ string: String, newBadge: Bool) {
        self.string = string
        self.newBadge = newBadge
    }
    
    public var body: some View {
        ZStack {
            Text(string)
            HStack(spacing: 0) {
                Text(string)
                    .foregroundColor(.clear)
                if newBadge {
                    CLNewBadge()
                        .offset(x: -2, y: -6)
                }
            }
        }
    }
}

struct CLTextWithNewBadge_Previews: PreviewProvider {
    static var previews: some View {
        CLTextWithNewBadge("Hallo", newBadge: true)
    }
}
