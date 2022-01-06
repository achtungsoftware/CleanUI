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

/// Global static variables are stored here
public struct CUGlobal {
    
    /// `mainWindow` is filled after ``CUStd/getMainUIWindow()``
    /// got called the first time. After that, ``CUStd/getMainUIWindow()`` will
    /// always return this `mainWindow` variable, to prevent that we search for the `UIWindow` multiple
    /// times and accidentally return the wrong `UIWindow`.
    public static var mainWindow: UIWindow? = nil
    
    /// Stores the global ``CUAlert`` array
    public static var alerts: CUAlert = CUAlert()
    
    /// Stores the global ``CUSheet`` array
    public static var sheets: CUSheet = CUSheet() 
    
    /// Stores the global ``CUInAppNotification`` array
    public static var inAppNotifications: CUInAppNotification = CUInAppNotification()
    
    /// Stores the global ``CUAlertMessages`` array
    public static var alertMessages: CUAlertMessages = CUAlertMessages()
}
