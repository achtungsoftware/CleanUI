//
//  CLTextWithNewBadge.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns a ``CLTextWithNewBadge`` (Text with optional CLNewBadge)
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
