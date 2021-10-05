//
//  DescriptiveNumber.swift
//  CleanUI
//
//  Created by Julian Gerhards on 04.10.21.
//

import SwiftUI

/// Returns a DescriptiveNumber with a number and an description, aligned vertically
public struct DescriptiveNumber: View {
    
    public enum Size {
        case normal, small
    }
    
    var number: Int
    var description: String
    var size: DescriptiveNumber.Size
    
    /// - Parameters:
    ///   - number: The number which will be described
    ///   - description: The description for the number
    ///   - size: The size, default is .normal
    public init(_ number: Int, description: String, size: DescriptiveNumber.Size = .normal) {
        self.number = number
        self.description = description
        self.size = size
    }
    
    public var body: some View {
        VStack {
            Text(String(number))
                .font(size == .small ? .subheadline : .body)
                .fontWeight(.bold)
            
            Text(description)
                .font(size == .small ? .caption : .footnote)
        }
    }
}
