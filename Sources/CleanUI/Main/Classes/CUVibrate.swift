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
import AudioToolbox
import Combine

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
    case none
    
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
            case .none:
                break
            }
        }
    }
}
