//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public typealias PlatformView = UIView

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
    
    /// Finds subviews from a specific type
    /// - Returns: An `Array` with the founded `UIViews`'s
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }
    
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
    
    /// Trys to find the first `UIScrollView` in `UIView`'s subviews
    var findFirstUISrollView: UIScrollView? {
        let arr = self.findViews(subclassOf: UIScrollView.self)
        
        if arr.count > 0 {
            return arr[0]
        }
        
        return nil
    }
    
    /// Try's to find a HostingView of a specific subview
    /// - Returns: The optional `UIView`
    func findHostingView() -> UIView? {
        var superview = self.superview
        while let s = superview {
            if NSStringFromClass(type(of: s)).contains("HostingView") {
                return s
            }
            superview = s.superview
        }
        return nil
    }
}
