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

/// A ``CLCircularProgress`` for indacting any type of progress
public struct CLCircularProgress: View {
    
    var progress: CGFloat
    var size: CLCircularProgress.Size
    var tint: CLCircularProgress.Tint
    
    /// - Parameters:
    ///   - progress: The progress CGFloat 0 -> 0%, 1 -> 100%
    ///   - size: The size ``CLCircularProgress/Size`` for the ``CLCircularProgress``
    ///   - tint: The tint ``CLCircularProgress/Tint`` for the ``CLCircularProgress``
    public init(_ progress: CGFloat, size: CLCircularProgress.Size = .medium, tint: CLCircularProgress.Tint = .auto) {
        self.progress = progress
        self.size = size
        self.tint = tint
    }
    
    public var body: some View {
        ZStack {
            Group {
                switch tint {
                case .light:
                    Color.white
                case .dark:
                    Color.black
                case .auto:
                    Color.defaultText
                case .knoggl:
                    CLKnogglGradient()
                }
            }
            .mask(
                Circle()
                    .trim(from: 0.0, to: min(progress, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round))
                    .foregroundColor(.black)
                    .rotationEffect(Angle(degrees: 270.0))
                    .padding(2)
            )
        }
        .frame(width: size == .small ? 16 : size == .medium ? 24 : 30, height: size == .small ? 16 : size == .medium ? 24 : 30)
    }
}

public extension CLCircularProgress {
    enum Size {
        case small, medium, big
    }
    
    enum Tint {
        case light, dark, auto, knoggl
    }
}
