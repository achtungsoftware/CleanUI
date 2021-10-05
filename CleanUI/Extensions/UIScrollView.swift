//
//  UIScrollView.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
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
