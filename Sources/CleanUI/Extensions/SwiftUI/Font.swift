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

public extension Font {
    
    /// Converts a Font to UIFont
    /// - Returns: returns the UIFont equivalent for the given Font
    func toUIFont() -> UIFont {
        switch self {
        case .largeTitle:
            return .preferredFont(forTextStyle: .largeTitle)
        case .title:
            return .preferredFont(forTextStyle: .title1)
        case .title2:
            return .preferredFont(forTextStyle: .title2)
        case .title3:
            return .preferredFont(forTextStyle: .title3)
        case .headline:
            return .preferredFont(forTextStyle: .headline)
        case .body:
            return .preferredFont(forTextStyle: .body)
        case .callout:
            return .preferredFont(forTextStyle: .callout)
        case .subheadline:
            return .preferredFont(forTextStyle: .subheadline)
        case .footnote:
            return .preferredFont(forTextStyle: .footnote)
        case .caption:
            return .preferredFont(forTextStyle: .caption1)
        case .caption2:
            return .preferredFont(forTextStyle: .caption2)
        default:
            return .preferredFont(forTextStyle: .body)
        }
    }
}
