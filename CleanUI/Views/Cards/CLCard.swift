//
//  CLCard.swift
//  CleanUI
//
//  Created by Julian Gerhards on 02.10.21.
//

import SwiftUI

/// Adds a ``CLCard`` style to a view without wrapping it inside a container
public struct CLCard<Content: View>: View {
    
    var content: () -> Content
    var accent2: Bool
    
    public init(accent2: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.accent2 = accent2
        self.content = content
    }
    
    public var body: some View {
        content()
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(RoundedRectangle(cornerRadius: 10).fill(accent2 ? Color.accent2 : Color.accent))
    }
}
