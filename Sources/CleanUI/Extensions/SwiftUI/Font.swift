//
//  Copyright © 2021 - present Julian Gerhards
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
