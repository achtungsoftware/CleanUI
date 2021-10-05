//
//  BlurView.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// BlurView is a UIViewRepresentable for an UIVisualEffectView
struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    /// - Parameter style: The UIBlurEffect.Style that should be applied
    init(_ style: UIBlurEffect.Style) {
        self.style = style
    }
    
    let view = UIVisualEffectView()
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        view.effect = UIBlurEffect(style: style)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
