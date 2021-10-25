//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import Combine

/// This is extension is mainly to provide a fullscreen back gesture.
extension UINavigationController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        transitioningDelegate = self
        interactivePopGestureRecognizer?.delegate = self
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.background
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        
        setupFullWidthBackGesture()
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushTransition()
        case .pop:
            return PopTransition()
        default:
            return nil
        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Removes the back button text in NaviagtionBar
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
    // Swipe back from everywhere on the screen
    private func setupFullWidthBackGesture() {
        let fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
        // The trick here is to wire up our full-width `fullWidthBackGestureRecognizer` to execute the same handler as
        // the system `interactivePopGestureRecognizer`. That's done by assigning the same "targets" (effectively
        // object and selector) of the system one to our gesture recognizer.
        guard
            let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
            let targets = interactivePopGestureRecognizer.value(forKey: "targets")
        else {
            return
        }
        
        fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
        fullWidthBackGestureRecognizer.delegate = self
        view.addGestureRecognizer(fullWidthBackGestureRecognizer)
    }
    
    /// Swipe back from everywhere on the screen
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        let isThereStackedViewControllers = viewControllers.count > 1
        
        // Allow swipe only right
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: view)
            if translation.x <=  0 {
                return false
            }
        }
        return isSystemSwipeToBackEnabled && isThereStackedViewControllers
    }
}
