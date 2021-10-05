//
//  OnRotate.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// The OnRotate modifier gives you the ability to react to device rotations
public struct OnRotate: ViewModifier {
    
    let action: (UIDeviceOrientation) -> Void
    
    /// - Parameter action: The action that should be called if the device was rotated
    public init(action: @escaping (UIDeviceOrientation) -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
