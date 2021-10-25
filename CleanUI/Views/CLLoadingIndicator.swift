//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import Combine

/// A ``CLLoadingIndicator`` for indicating unknown progress
public struct CLLoadingIndicator: View {
    
    public enum Style {
        case standard(_ tint: Color = Color.defaultText)
        case knoggl
    }
    
    var style: CLLoadingIndicator.Style
    var withDelay: Bool
    var isImageOverlay: Bool
    
    /// - Parameters:
    ///   - style: The ``CLLoadingIndicator`` style ``CLLoadingIndicator/Style``
    ///   - withDelay: Should the ``CLLoadingIndicator`` have a delay before showing?
    ///   - isImageOverlay: If true, the visibility gets improved if the ``CLLoadingIndicator`` overlays an image
    public init(style: CLLoadingIndicator.Style = .standard(), withDelay: Bool = true, isImageOverlay: Bool = false){
        self.withDelay = withDelay
        self.style = style
        self.isImageOverlay = isImageOverlay
    }
    
    @State private var show: Bool = false
    
    public var body: some View {
        ZStack {
            if isImageOverlay {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            if show {
                switch style {
                case .standard(let tint):
                    ProgressView()
                        .foregroundColor(tint)
                case .knoggl:
                    CLKnogglGradient()
                        .frame(width: 20, height: 20, alignment: .center)
                        .mask(ProgressView().padding(-10))
                }
            }
        }
        .onLoad {
            if withDelay {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation {
                        show = true
                    }
                }
            }else {
                show = true
            }
        }
    }
}
