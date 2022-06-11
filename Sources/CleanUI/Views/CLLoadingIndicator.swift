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

/// A ``CLLoadingIndicator`` for indicating unknown progress
public struct CLLoadingIndicator: View {
    
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
    
    @StateObject private var model: ViewModel = ViewModel()
    
    public var body: some View {
        ZStack {
            if isImageOverlay {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            if model.show {
                switch style {
                case .standard(let tint):
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: tint))
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
                        model.show = true
                    }
                }
            }else {
                model.show = true
            }
        }
    }
}

public extension CLLoadingIndicator {
    enum Style {
        case standard(_ tint: Color = Color.defaultText)
        case knoggl
    }
 
    class ViewModel: ObservableObject {
        @Published var show: Bool = false
    }
}

struct CLLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            CLLoadingIndicator()
            CLLoadingIndicator(style: .knoggl)
            CLLoadingIndicator(style: .standard(.defaultRed))
            CLLoadingIndicator(isImageOverlay: true)
        }
    }
}
