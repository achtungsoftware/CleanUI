//
//  CLSheetTitle.swift
//  CleanUI
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI

/// Returns a title view for a ``CUSheet``
public struct CLSheetTitle: View {
    
    var title: String
    
    /// - Parameter title: The title `String`
    public init(_ title: String) {
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.defaultText)
        }
    }
}
