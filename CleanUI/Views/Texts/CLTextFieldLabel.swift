//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// Returns a ``CLTextFieldLabel``
public struct CLTextFieldLabel: View {
    
    var label: String
    
    /// - Parameter label: The label `String
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
