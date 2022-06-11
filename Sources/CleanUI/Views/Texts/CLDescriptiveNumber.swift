//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// Returns a ``CLDescriptiveNumber`` with a number and an description, aligned vertically
public struct CLDescriptiveNumber: View {
    
    var number: Int
    var description: String
    var size: Size
    
    /// - Parameters:
    ///   - number: The number which will be described
    ///   - description: The description for the number
    ///   - size: The size, default is `.normal
    public init(_ number: Int, description: String, size: Size = .normal) {
        self.number = number
        self.description = description
        self.size = size
    }
    
    public var body: some View {
        VStack {
            Text(number.abbreviate())
                .font(size == .small ? .subheadline : .body)
                .fontWeight(.bold)
            
            Text(description)
                .font(size == .small ? .caption : .footnote)
        }
    }
}

public extension CLDescriptiveNumber {
    enum Size {
        case normal, small
    }
}

struct CLDescriptiveNumber_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            CLDescriptiveNumber(214312, description: "Number", size: .small)
            CLDescriptiveNumber(2332, description: "Number", size: .normal)
            CLDescriptiveNumber(214312, description: "Number", size: .small)
            CLDescriptiveNumber(2332, description: "Number", size: .normal)
        }
    }
}
