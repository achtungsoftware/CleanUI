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

/// This class helps to get translations
public class CULanguage {
    
    /// Get a string from the CleanUI localization
    /// - Parameter keyString: The description key
    /// - Returns: The string
    static func getStringCleanUI(_ keyString: String) -> String {
        NSLocalizedString(keyString, tableName: nil, bundle: Bundle.module, value: "", comment: "")
    }
    
    /// Get a string from the CleanUI localization and replace a specified part of the string
    /// - Parameters:
    ///   - keyString: The description key
    ///   - replace: The part that should be replaced
    ///   - with: The string that replaces "replace"
    /// - Returns: The modified string
    static func getStringWithReplaceCleanUI(_ keyString: String, replace: String, with: String) -> String {
        let text = NSLocalizedString(keyString, tableName: nil, bundle: Bundle.module, value: "", comment: "")
        let replaced = text.replacingOccurrences(of: replace, with: with)
        return replaced
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
