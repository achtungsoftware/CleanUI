//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

/// This is a ``CLScrollView`` which is mainly an SwiftUI.ScrollView. In contrast to SwiftUI.CLScrollView, ``CLScrollView``
/// is able to return the scroll offset
public struct CLScrollView<Content: View>: View {
    
    let axes: Axis.Set
    let showsIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: Content
    
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the
    ///     vertical axis.
    ///   - showsIndicators: A Boolean value that indicates whether the scroll
    ///     view displays the scrollable component of the content offset, in a way
    ///     suitable for the platform. The default value for this parameter is
    ///     `true`.
    ///   - offsetChanged: This is a optional callback which fires every time the scroll offset changed
    ///   - content: The view builder that creates the scrollable view.
    public init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, offsetChanged: @escaping (CGPoint) -> Void = { _ in }, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: geometry.frame(in: .named("scrollView")).origin
                    )
                }.frame(width: 0, height: 0)
                content
            }
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}
