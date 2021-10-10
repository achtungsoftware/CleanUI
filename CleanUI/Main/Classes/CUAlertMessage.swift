//
//  CUAlertMessage.swift
//  CleanUI
//
//  Created by Julian Gerhards on 10.10.21.
//

import SwiftUI

/// ``CUAlertMessage`` is able to show a toast like message at the bottom of the
/// screen
public class CUAlertMessage {
    
    public enum AlertType {
        case normal
        case error
    }
    
    /// Shows a new ``CUAlertMessage``
    /// - Parameters:
    ///   - message: The message label to show
    ///   - type: The ``CUAlertMessage/AlertType`` alert type
    public static func show(message: String, type: CUAlertMessage.AlertType = .normal) {
        if let controller = CUStandard.getMainUIWindow()?.rootViewController {
            let labelContainer = UIView(frame: CGRect())
            
            switch type {
            case .normal:
                labelContainer.backgroundColor = UIColor.accent
            case .error:
                labelContainer.backgroundColor = UIColor.defaultRed
            }
            
            labelContainer.alpha = 0.0
            labelContainer.layer.cornerRadius = 25
            labelContainer.clipsToBounds = true
            
            let messageLabel = UILabel(frame: CGRect())
            
            switch type {
            case .normal:
                messageLabel.textColor = UIColor.defaultText
            case .error:
                messageLabel.textColor = UIColor.white
            }
            
            messageLabel.textAlignment = .center;
            messageLabel.font.withSize(12.0)
            messageLabel.text = message
            messageLabel.clipsToBounds = true
            messageLabel.numberOfLines = 0
            
            labelContainer.layer.masksToBounds = false
            labelContainer.layer.shadowColor = UIColor.black.cgColor
            labelContainer.layer.shadowOpacity = 0.1
            labelContainer.layer.shadowOffset = .zero
            labelContainer.layer.shadowRadius = 10
            
            labelContainer.layer.borderWidth = 0.5
            labelContainer.layer.borderColor = UIColor.defaultBorder.cgColor
            
            labelContainer.addSubview(messageLabel)
            controller.view.addSubview(labelContainer)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            labelContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let a1 = NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: labelContainer, attribute: .leading, multiplier: 1, constant: 15)
            let a2 = NSLayoutConstraint(item: messageLabel, attribute: .trailing, relatedBy: .equal, toItem: labelContainer, attribute: .trailing, multiplier: 1, constant: -15)
            let a3 = NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .equal, toItem: labelContainer, attribute: .bottom, multiplier: 1, constant: -15)
            let a4 = NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: labelContainer, attribute: .top, multiplier: 1, constant: 15)
            labelContainer.addConstraints([a1, a2, a3, a4])
            
            let c2 = NSLayoutConstraint(item: labelContainer, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: controller.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            
            let c3 = NSLayoutConstraint(item: labelContainer,
                                        attribute:.width,
                                        relatedBy:.lessThanOrEqual,
                                        toItem: controller.view,
                                        attribute:.width,
                                        multiplier:0.9,
                                        constant:0);
            
            let c1 = NSLayoutConstraint(item: labelContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -110)
            controller.view.addConstraints([c1,c2,c3])
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                labelContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
                    labelContainer.alpha = 0.0
                }, completion: {_ in
                    labelContainer.removeFromSuperview()
                })
            })
        }
    }
    
}
