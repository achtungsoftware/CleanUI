//
//  TextFieldLabel.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns a ``TextFieldLabel``
public struct TextFieldLabel: View {
    
    var label: String
    
    /// - Parameter label: The label String
    public init(_ label: String) {
        self.label = label
    }
    
    public var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color.grayText)
            
            Spacer()
        }
        .padding(.top, 8)
    }
}
