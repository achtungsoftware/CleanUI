//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// This class helps to get translations
public class CULanguage {
    
    /// Get a string from the CleanUI localization
    /// - Parameter keyString: The description key
    /// - Returns: The string
    static func getStringCleanUI(_ keyString: String) -> String {
        NSLocalizedString(keyString, tableName: nil, bundle: Bundle(for: self), value: "", comment: "")
    }
    
    /// Get a string
    /// - Parameter keyString: The description key
    /// - Returns: The string
    public static func getString(_ keyString: String) -> String {
        return NSLocalizedString(keyString, comment: "")
    }
    
    /// Get a string and replace a specified part of the string
    /// - Parameters:
    ///   - keyString: The description key
    ///   - replace: The part that should be replaced
    ///   - with: The string that replaces "replace"
    /// - Returns: The modified string
    public static func getStringWithReplace(_ keyString: String, replace: String, with: String) -> String {
        let text = NSLocalizedString(keyString, comment: "")
        let replaced = text.replacingOccurrences(of: replace, with: with)
        return replaced
    }
}
