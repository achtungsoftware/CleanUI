//
//  FeedFooter.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns a FeedFooter for implementation in feeds or forms
public struct FeedFooter: View {
    
    var title: String
    
    /// - Parameter title: The title String
    init(_ title: String) {
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
