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

/// Returns a title view for a ``CUSheet``
public struct CLSheetTitle: View {
    
    var title: String
    
    /// - Parameter title: The title `String`
    public init(_ title: String) {
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.grayText)
        }
    }
}

struct CLSheetTitle_Previews: PreviewProvider {
    static var previews: some View {
        CLSheetTitle("This is a Title")
    }
}
