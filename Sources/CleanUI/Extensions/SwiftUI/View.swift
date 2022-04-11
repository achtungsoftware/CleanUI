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

public extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the frameworks default shadow to a view
    /// - Returns: The view with the default shadow
    func defaultShadow() -> some View {
        return self.shadow(color: Color.black.opacity(0.4), radius: 3)
    }
    
    /// Clipshapes the view wit an ``RoundedCorner`` `Shape`
    /// - Parameters:
    ///   - radius: The radius
    ///   - corners: The corners which the radius should apply to
    /// - Returns: The clipped `View`
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// Reads the size `CGSize` from a `View` and updates it automatically
    /// Thanks to https://fivestars.blog/swiftui/swiftui-share-layout-information.html
    /// - Parameter onChange: The onchange event
    /// - Returns: The measured `View`
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    /// Adds an action to perform when `UIApplication` will enter foreground
    /// - Parameter action: The action to perform
    /// - Returns: The same `View` with the logic added
    func willEnterForeground(perform action: @escaping () -> Void) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { value in
                action()
            }
    }
    
    /// Adds an action to perform when `UIApplication` did enter background
    /// - Parameter action: The action to perform
    /// - Returns: The same `View` with the logic added
    func didEnterBackground(perform action: @escaping () -> Void) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { value in
                action()
            }
    }
}

internal struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
