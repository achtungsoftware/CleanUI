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

/// This is the ``CUViewModel`` class for ``CLAlert``
internal class CLAlertViewModel: CUViewModel {
    
    @Published var isShowing: Bool = false
    
    override func didLoad() {
        super.didLoad()
        
        // Show the alert with animation
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            isShowing = true
        }
    }
    
    /// Closes / dismisses the alert
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.25)) {
            isShowing = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            CUAlert.clearAll()
        }
    }
}
