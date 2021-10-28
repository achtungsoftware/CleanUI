//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

final class PushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.26
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        
        let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = -fromViewFinalFrame.width
        
        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!
        
        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = toView.frame.size.width
        
        toView.frame = toViewInitialFrame
        container.addSubview(toView)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.fastSlowDown)
        CATransaction.setCompletionBlock({
            toVC.view.isHidden = false
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        UIView.animate(withDuration: 0.26) {
            toView.frame = fromViewInitialFrame
            fromView.frame = CGRect(x: fromViewFinalFrame.origin.x / 4, y: fromViewFinalFrame.origin.y, width: fromViewFinalFrame.size.width, height: fromViewFinalFrame.size.height)
        }
        
        CATransaction.commit()
    }
    
    
}

final class PopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.26
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        
        var fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        fromViewInitialFrame.origin.x = 0
        
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = fromViewFinalFrame.width
        
        let fromView = fromVC.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = -toView.frame.size.width / 4
        
        toView.frame = toViewInitialFrame
        
        container.insertSubview(toView, at: 0)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.fastSlowDown)
        CATransaction.setCompletionBlock({
            fromVC.view.isHidden = false
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        UIView.animate(withDuration: 0.26) {
            fromView.frame = fromViewFinalFrame
            toView.frame = fromViewInitialFrame
        }
        
        CATransaction.commit()
    }
}

extension CAMediaTimingFunction {
    static let fastSlowDown = CAMediaTimingFunction(controlPoints: 0.30, 0.10, 0, 1)
}
