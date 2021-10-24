//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// This is the ``CUViewModel`` class for ``CLAlert``
internal class CLAlertViewModel: CUViewModel {
    
    @Published var isShowing: Bool = false
    
    override func didLoad() {
        super.didLoad()
        
        // Show the alert with animation
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            isShowing = true
        }
    }
    
    /// Closes / dismisses the alert
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.25)) {
            isShowing = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            CUAlert.clearAll()
        }
    }
}
