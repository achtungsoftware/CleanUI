//
//  UIViewController.swift
//  CleanUI
//
//  Created by Julian Gerhards on 15.10.21.
//

import SwiftUI
import Combine

public extension UIViewController {
    
    /// Finds `UIViewController` children from a specific type
    /// - Returns: An `Array` of `UIViewController` children
    func findChilds<T: UIViewController>(subclassOf: T.Type) -> [T] {
        return recursiveChild.compactMap { $0 as? T }
    }
    
    var recursiveChild: [UIViewController] {
        return children + children.flatMap { $0.recursiveChild }
    }
    
    /// Trys to find the first `UINavigationController` in `UIViewController` children
    var findFirstUINavigationController: UINavigationController? {
        let arr = self.findChilds(subclassOf: UINavigationController.self)
        
        if arr.count > 0 {
            return arr[0]
        }
        
        return nil
    }
}
