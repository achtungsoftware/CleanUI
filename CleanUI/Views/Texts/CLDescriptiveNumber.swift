//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
