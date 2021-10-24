//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CLNavigationView`` is a wrapper for NavigationView.
public struct CLNavigationView<Content: View>: View {
    
    var content: () -> Content
    
    /// - Parameter content: The root view for the navigation stack
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        NavigationView {
            content()
        }
        .navigationViewStyle(.stack)
    }
}
