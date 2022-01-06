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

/// A ``CLLinearProgress``  for indacting any type of progress
public struct CLLinearProgress: View {
    
    var progress: CGFloat
    
    /// - Parameter progress: The current progress 0 -> 0%, 100 -> 100%
    public init(_ progress: CGFloat) {
        self.progress = progress
    }
    
    public var body: some View {
        CLKnogglGradient()
            .frame(height: 4)
            .mask(
                ProgressView(value: progress, total: 100)
                    .progressViewStyle(LinearProgressViewStyle())
            )
    }
}
