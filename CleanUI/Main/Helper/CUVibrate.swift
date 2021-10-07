//
//  CUVibrate.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI
import AudioToolbox

/// ``CUVibrate`` helps you to play vibrations
public enum CUVibrate {
    
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    @available(iOS 13.0, *)
    case soft
    @available(iOS 13.0, *)
    case rigid
    case selection
    case oldSchool
    
    /// Fire the vibration
    public func vibrate() {
        let feedbackSupportLevel = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int
        
        DispatchQueue.main.async {
            switch self {
            case .error:
                if let feedbackSupportLevel = feedbackSupportLevel, feedbackSupportLevel <= 1 {
                    AudioServicesPlaySystemSound(1521)
                }else {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
            case .success:
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            case .warning:
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            case .light:
                if let feedbackSupportLevel = feedbackSupportLevel, feedbackSupportLevel <= 1 {
                    AudioServicesPlaySystemSound(1519)
                }else {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            case .medium:
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            case .heavy:
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            case .soft:
                if let feedbackSupportLevel = feedbackSupportLevel, feedbackSupportLevel <= 1 {
                    AudioServicesPlaySystemSound(1519)
                }else {
                    if #available(iOS 13.0, *) {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    }
                }
            case .rigid:
                if #available(iOS 13.0, *) {
                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                }
            case .selection:
                UISelectionFeedbackGenerator().selectionChanged()
            case .oldSchool:
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
}
