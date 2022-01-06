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

/// This is the base class for every view model
open class CUViewModel: ObservableObject {
    
    public init () {}

    /// Every ``CUViewModel`` gets its own unique id
    public let id: UUID = UUID()
    
    /// We save the `Date` when the ``CUViewModel`` got created
    public let createdDate: Date = Date()
    
    /// This method returns the number of seconds since the time the ``CUViewModel`` got created
    /// - Returns: The number of seconds since the time the ``CUViewModel`` got created
    public func activeSinceSeconds() -> Int {
        return Int(Date().timeIntervalSince(createdDate))
    }
    
    /// This method should get called in `view.onAppear {}`
    open func didAppear() {}
    
    /// This method should get called in `view.onLoad {}`
    open func didLoad() {}
}
