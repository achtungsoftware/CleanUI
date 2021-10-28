//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public extension GeometryProxy {
    var maxWidth: CGFloat {
        size.width - safeAreaInsets.leading - safeAreaInsets.trailing
    }
}
