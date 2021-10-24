//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// The ``CUAlertModel`` is used for ``CUSheet``, ``CUAlert``, ``CUInAppNotification`` and ``CUAlertMessage``
public struct CUAlertModel: Identifiable, Equatable {
    public var id = UUID()
    public var view: UIView
    public var shouldDismiss: Bool = false
}
