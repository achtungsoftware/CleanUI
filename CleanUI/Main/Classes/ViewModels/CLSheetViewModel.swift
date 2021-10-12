//
//  CLSheetViewModel.swift
//  CleanUI
//
//  Created by Julian Gerhards on 12.10.21.
//

import SwiftUI

/// This is the ``CUViewModel`` class for ``CLSheet``
internal class CLSheetViewModel: CUViewModel {
    
    @Published var isShowing: Bool = false
    @Published var showBackground: Bool = false
    @Published var offset = CGSize.zero
    @Published var height: CGFloat = 0
    
    /// Shows the alert
    func show() {
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
