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
    
    /// Trys to return the index of an object inside a `Identifiable` `Array`.
    /// - Parameter array: The `Identifiable` `Array` in which we search for the index
    /// - Parameter searchedObject: The `Identifiable` to search for
    /// - Returns: The index if found, else `0`
    public static func getArrayIndex<T: Identifiable>(_ array: [T], searchedObject: T) -> Int {
        var currentIndex: Int = 0
        for obj in array
        {
            if obj.id == searchedObject.id {
                return currentIndex
            }
            currentIndex += 1
        }
        return 0
    }
}
