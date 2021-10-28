//
//  Copyright © 2021 - present Julian Gerhards
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
