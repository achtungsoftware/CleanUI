//
//  NewBadge.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns an animated badge for indicating that something is unseen or new
public struct NewBadge: View {
    
    var withBackground: Bool
    
    var defaultSize: CGFloat = 6
    @State private var animationAmount: CGFloat = 1
    
    /// - Parameter withBackground: Should this NewBadge have a background (color) ?
    public init(_ withBackground: Bool = true) {
        self.withBackground = withBackground
    }
    
    public var body: some View {
        ZStack {
            if(withBackground){
                Circle()
                    .fill(Color.background)
                    .frame(width: defaultSize+8, height: defaultSize+8)
            }
            
            Circle()
                .fill(Color.primary)
                .frame(width: defaultSize, height: defaultSize)
                .background(
                    Circle()
                        .stroke(Color.primary)
                        .scaleEffect(animationAmount * 1.2)
                        .opacity(animationAmount == 2 ? 0 : 1)
                        .animation(
                            Animation.easeOut(duration: 1.2)
                                .repeatForever(autoreverses: false),
                            value: animationAmount == 2
                        )
                )
        }
        .allowsHitTesting(false)
        .onLoad {
            animationAmount = 2
        }
    }
}
