//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// This is the ``CUViewModel`` class for ``CLSheet``
internal class CLSheetViewModel: CUViewModel {
    
    @Published var isShowing: Bool = false
    @Published var showBackground: Bool = false
    @Published var offset = CGSize.zero
    @Published var height: CGFloat = 0
    
    override func didLoad() {
        super.didLoad()
        
        // Show the sheet with animation
        withAnimation(Animation.interpolatingSpring(mass: 0.2, stiffness: 29.5, damping: 12, initialVelocity: 10)){
            isShowing = true
            showBackground = true
        }
    }
    
    /// Closes / dismisses the sheet
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            offset.height = height
            showBackground = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            CUSheet.clearAll()
        }
    }
}
