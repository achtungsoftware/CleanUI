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

/// The ``OnLoad`` ViewModifier allows to add a `.onLoad { action() }` to a view,
/// The action() never gets called twice
public struct OnLoad: ViewModifier {
    
    @State private var didLoad = false
    private let action: (() -> Void)
    
    /// - Parameter action: The action gets called only once on appear. Gets not called if already appeared
    public init(perform action: @escaping (() -> Void)) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if !didLoad {
                    action()
                    didLoad = true
                }
            }
    }
}

public extension View {
    /// Applies the view modifier ``OnLoad`` to a view
    /// - Parameter action: The action gets called only once on appear. Gets not called if already appeared
    /// - Returns: The view with the ``OnLoad`` modifier
    func onLoad(perform action: @escaping (() -> Void)) -> some View {
        modifier(OnLoad(perform: action))
    }
}
