//
//  CLNavigationView.swift
//  CleanUI
//
//  Created by Julian Gerhards on 08.10.21.
//

import SwiftUI

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
