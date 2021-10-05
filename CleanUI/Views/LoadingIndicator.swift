//
//  LoadingIndicator.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// A ``LoadingIndicator`` for indicating unknown progress
public struct LoadingIndicator: View {
    
    public enum Style {
        case standard(_ tint: Color = Color.defaultText)
        case knoggl
    }
    
    var style: LoadingIndicator.Style
    var withDelay: Bool
    var isImageOverlay: Bool
    
    /// - Parameters:
    ///   - style: The ``LoadingIndicator`` style ``LoadingIndicator/Style``
    ///   - withDelay: Should the ``LoadingIndicator`` have a delay before showing?
    ///   - isImageOverlay: If true, the visibility gets improved if the ``LoadingIndicator`` overlays an image
    public init(style: LoadingIndicator.Style = .standard(), withDelay: Bool = true, isImageOverlay: Bool = false){
        self.withDelay = withDelay
        self.style = style
        self.isImageOverlay = isImageOverlay
    }
    
    @State private var show: Bool = false
    
    public var body: some View {
        ZStack {
            if(isImageOverlay){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            if(show){
                switch style {
                case .standard(let tint):
                    ProgressView()
                        .foregroundColor(tint)
                case .knoggl:
                    KnogglGradient()
                        .frame(width: 20, height: 20, alignment: .center)
                        .mask(ProgressView().padding(-10))
                }
            }
        }
        .onLoad {
            if(withDelay){
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
