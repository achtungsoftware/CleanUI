//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

extension CLIcon.Offset {
    
    /// Converts the ``CLIcon.Offset`` to a `CGSize`
    /// - Returns: The offset as `CGSize`
    func toCGSize() -> CGSize {
        switch self {
        case .leading(let of):
            return CGSize(width: of, height: 0)
        case .trailing(let of):
            return CGSize(width: -of, height: 0)
        case .bottom(let of):
            return CGSize(width: 0, height: -of)
        case .top(let of):
            return CGSize(width: 0, height: of)
        }
    }
}
