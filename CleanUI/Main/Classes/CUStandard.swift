//
//  CUStandard.swift
//  CleanUI
//
//  Created by Julian Gerhards on 10.10.21.
//

import SwiftUI

/// The `CUStandard` class provides a collection of static standard functions
public class CUStandard {
    
    /// Trys to get the main `UIWindow`
    /// - Returns: The main `UIWindow`
    public static func getMainUIWindow() -> UIWindow? {
        if let mainWindow = CUGlobal.mainWindow {
            return mainWindow
        }else {
            return UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
        }
    }
}
