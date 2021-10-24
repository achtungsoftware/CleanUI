//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// Returns a ``CLDescriptiveNumber`` with a number and an description, aligned vertically
public struct CLDescriptiveNumber: View {
    
    public enum Size {
        case normal, small
    }
    
    var number: String
    var description: String
    var size: CLDescriptiveNumber.Size
    
    /// - Parameters:
    ///   - number: The number which will be described
    ///   - description: The description for the number
    ///   - size: The size, default is `.normal
    public init(_ number: String, description: String, size: CLDescriptiveNumber.Size = .normal) {
        self.number = number
        self.description = description
        self.size = size
    }
    
    public var body: some View {
        VStack {
            Text(Int(number)!.abbreviate())
                .font(size == .small ? .subheadline : .body)
                .fontWeight(.bold)
            
            Text(description)
                .font(size == .small ? .caption : .footnote)
        }
    }
}
