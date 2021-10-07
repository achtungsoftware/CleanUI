//
//  CLFeedFooter.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns a ``CLFeedFooter`` for implementation in feeds or forms
public struct CLFeedFooter: View {
    
    var title: String
    
    /// - Parameter title: The title String
    public init(_ title: String) {
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.grayText)
            Spacer()
        }
        .padding(.bottom, 10)
    }
}
