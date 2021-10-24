//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// Global static variables are stored here
public struct CUGlobal {
    
    /// `mainWindow` is filled after ``CUStandard/getMainUIWindow()``
    /// got called the first time. After that, ``CUStandard/getMainUIWindow()`` will
    /// always return this `mainWindow` variable, to prevent that we search for the `UIWindow` multiple
    /// times and accidentally return the wrong `UIWindow`.
    public static var mainWindow: UIWindow? = nil
    
    /// Stores the global ``CUAlerts`` array
    public static var alerts: CUAlert = CUAlert()
    
    /// Stores the global ``CUSheets`` array
    public static var sheets: CUSheet = CUSheet() 
    
    /// Stores the global ``CUInAppNotifications`` array
    public static var inAppNotifications: CUInAppNotifications = CUInAppNotifications()
    
    /// Stores the global ``CUAlertMessages`` array
    public static var alertMessages: CUAlertMessages = CUAlertMessages()
}
