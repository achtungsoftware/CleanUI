//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// Returns a ``CLNewBadge`` for indicating that something is unseen or new
public struct CLNewBadge: View {
    
    var withBackground: Bool
    
    var defaultSize: CGFloat = 6
    @State private var animationAmount: CGFloat = 1
    
    /// - Parameter withBackground: Should this ``CLNewBadge`` have a background (color) ?
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
                .fill(Color.primaryColor)
                .frame(width: defaultSize, height: defaultSize)
                .background(
                    Circle()
                        .stroke(Color.primaryColor)
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
