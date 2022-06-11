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

/// Returns a ``CLNewBadge`` for indicating that something is unseen or new
public struct CLNewBadge: View {
    
    var withBackground: Bool
    
    /// - Parameter withBackground: Should this ``CLNewBadge`` have a background (color) ?
    public init(_ withBackground: Bool = true) {
        self.withBackground = withBackground
    }
    
    @StateObject private var model: ViewModel = ViewModel()
    
    public var body: some View {
        ZStack {
            if withBackground {
                Circle()
                    .fill(Color.background)
                    .frame(width: model.defaultSize + 8, height: model.defaultSize + 8)
            }
            
            Circle()
                .fill(Color.primaryColor)
                .frame(width: model.defaultSize, height: model.defaultSize)
                .background(
                    Circle()
                        .stroke(Color.primaryColor)
                        .scaleEffect(model.animationAmount * 1.2)
                        .opacity(model.animationAmount == 2 ? 0 : 1)
                        .animation(
                            Animation.easeOut(duration: 1.2)
                                .repeatForever(autoreverses: false),
                            value: model.animationAmount == 2
                        )
                )
        }
        .allowsHitTesting(false)
        .onLoad {
            model.animationAmount = 2
        }
    }
}

internal extension CLNewBadge {
    class ViewModel: ObservableObject {
        @Published var defaultSize: CGFloat = 6
        @Published var animationAmount: CGFloat = 1
    }
}

struct CLNewBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CLNewBadge()
            CLNewBadge(true)
        }
    }
}
