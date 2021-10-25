//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import Combine

/// A class for handling DispatchQueues. Only sugar but makes it easy to remember
public class CUThreadHelper {
    
    public enum async {
    case userInteractive
    case userInitiated
    case utility
    case background
    case main
        
        
        /// Runs the defined callback
        /// - Parameter callback: The callback
        public func run(_ callback: @escaping () -> Void) {
            switch self {
            case .userInitiated:
                DispatchQueue.global(qos: .userInitiated).async {
                    callback()
                }
            case .utility:
                DispatchQueue.global(qos: .utility).async {
                    callback()
                }
            case .background:
                DispatchQueue.global(qos: .background).async {
                    callback()
                }
            case .main:
                DispatchQueue.main.async {
                    callback()
                }
            case .userInteractive:
                DispatchQueue.global(qos: .userInteractive).async {
                    callback()
                }
            }
        }
    }
}

