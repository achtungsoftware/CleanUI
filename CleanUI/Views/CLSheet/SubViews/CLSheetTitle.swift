//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

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
