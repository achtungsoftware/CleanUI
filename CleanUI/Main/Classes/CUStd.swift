//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// The `CUStd` class provides a collection of static standard functions
public class CUStd {
    
    /// Trys to get the main `UIWindow`
    /// - Returns: The main `UIWindow`
    public static func getMainUIWindow() -> UIWindow? {
        if let mainWindow = CUGlobal.mainWindow {
            return mainWindow
        }else {
            CUGlobal.mainWindow = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
            
            return CUGlobal.mainWindow
        }
    }
}
