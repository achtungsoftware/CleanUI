//
//  UIView.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

public extension UIView {
    
    /// Makes an screenshot from the given UIView
    /// - Returns: Returns an UIImage
    func screenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, self.contentScaleFactor)
        
        drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if(image != nil){
            return image!
        }
        return UIImage()
    }
    
    /// ONLY TESTING
    func isVisible() -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: self, inView: self.superview)
    }
}
