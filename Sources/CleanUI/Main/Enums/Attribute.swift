//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public enum Attribute {
    case links(onTapAction: ((String) -> Void)? = nil)
    case hashtags(onTapAction: ((String) -> Void)? = nil)
    case mentions(onTapAction: ((String) -> Void)? = nil)
}
