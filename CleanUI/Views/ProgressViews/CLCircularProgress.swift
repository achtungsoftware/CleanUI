//
//  CLCircularProgress.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// A ``CLCircularProgress`` for indacting any type of progress
public struct CLCircularProgress: View {
    
    public enum Size {
        case small, medium, big
    }
    
    public enum Tint {
        case light, dark, auto, knoggl
    }
    
    var progress: CGFloat
    var size: CLCircularProgress.Size
    var tint: CLCircularProgress.Tint
    
    /// - Parameters:
    ///   - progress: The progress CGFloat 0 -> 0%, 1 -> 100%
    ///   - size: The size ``CLCircularProgress/Size`` for the ``CLCircularProgress``
    ///   - tint: The tint ``CLCircularProgress/Tint`` for the ``CLCircularProgress``
    public init(_ progress: CGFloat, size: CLCircularProgress.Size = .medium, tint: CLCircularProgress.Tint = .auto) {
        self.progress = progress
        self.size = size
        self.tint = tint
    }
    
    public var body: some View {
        ZStack {
            Group {
                switch tint {
                case .light:
                    Color.white
                case .dark:
                    Color.black
                case .auto:
                    Color.defaultText
                case .knoggl:
                    CLKnogglGradient()
                }
            }
            .mask(
                Circle()
                    .trim(from: 0.0, to: min(progress, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round))
                    .foregroundColor(.black)
                    .rotationEffect(Angle(degrees: 270.0))
                    .padding(2)
            )
        }
        .frame(width: size == .small ? 16 : size == .medium ? 24 : 30, height: size == .small ? 16 : size == .medium ? 24 : 30)
    }
}
