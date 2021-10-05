//
//  BlurView.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// ``BlurView`` is a UIViewRepresentable for an UIVisualEffectView
public struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    /// - Parameter style: The UIBlurEffect.Style that should be applied
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