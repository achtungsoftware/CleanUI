//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// Returns a ``CLTextWithNewBadge`` (Text with optional ``CLNewBadge`)
public struct CLTextWithNewBadge: View {
    
    var string: String
    var newBadge: Bool
    
    /// - Parameters:
    ///   - string: The text String
    ///   - newBadge: Should a ``CLNewBadge`` be applied?
    public init(_ string: String, newBadge: Bool) {
        self.string = string
        self.newBadge = newBadge
    }
    
    public var body: some View {
        ZStack {
            Text(string)
            HStack(spacing: 0) {
                Text(string)
                    .foregroundColor(.clear)
                if(newBadge){
                    CLNewBadge()
                        .offset(x: -2, y: -6)
                }
            }
        }
    }
}
