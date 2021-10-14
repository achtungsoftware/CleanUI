//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

public extension UIScrollView {
    
    /// Scrolls the UIScrollView to the top
    func scrollToTop() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut) {
            self.setContentOffset(.zero, animated: false)
        }
    }
}
