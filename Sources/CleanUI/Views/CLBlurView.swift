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

/// ``CLBlurView`` is a UIViewRepresentable for an `UIVisualEffectView`
public struct CLBlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    /// - Parameter style: The `UIBlurEffect.Style` that should be applied
    public init(_ style: UIBlurEffect.Style) {
        self.style = style
    }
    
    let view = UIVisualEffectView()
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        view.effect = UIBlurEffect(style: style)
        return view
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct CLBlurView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CLKnogglGradient()
            CLBlurView(.systemMaterialDark)
        }
    }
}
