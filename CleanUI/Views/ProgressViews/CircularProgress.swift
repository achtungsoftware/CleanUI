//
//  CircularProgress.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// A ``CircularProgress`` for indacting any type of progress
public struct CircularProgress: View {
    
    public enum Size {
        case small, medium, big
    }
    
    public enum Tint {
        case light, dark, auto, knoggl
    }
    
    var progress: CGFloat
    var size: CircularProgress.Size
    var tint: CircularProgress.Tint
    
    /// - Parameters:
    ///   - progress: The progress CGFloat 0 -> 0%, 1 -> 100%
    ///   - size: The size ``CircularProgress/Size`` for the ``CircularProgress``
    ///   - tint: The tint ``CircularProgress/Tint`` for the ``CircularProgress``
    public init(_ progress: CGFloat, size: CircularProgress.Size = .medium, tint: CircularProgress.Tint = .auto) {
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
                    KnogglGradient()
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
