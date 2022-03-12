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

/// The ``OnRotate`` modifier gives you the ability to react to device rotations
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

public extension View {
    /// Applies the view modifier ``OnRotate`` to a view
    /// - Parameter action: The on rotate action
    /// - Returns: The view with the ``OnRotate`` modifier
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        modifier(OnRotate(action: action))
    }
}
