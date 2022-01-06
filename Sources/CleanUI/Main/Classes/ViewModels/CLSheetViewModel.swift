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

/// This is the ``CUViewModel`` class for ``CLSheet``
internal class CLSheetViewModel: CUViewModel {
    
    @Published var isShowing: Bool = false
    @Published var showBackground: Bool = false
    @Published var offset = CGSize.zero
    @Published var height: CGFloat = 0
    
    override func didLoad() {
        super.didLoad()
        
        // Show the sheet with animation
        withAnimation(Animation.interpolatingSpring(mass: 0.2, stiffness: 29.5, damping: 12, initialVelocity: 10)){
            isShowing = true
            showBackground = true
        }
    }
    
    /// Closes / dismisses the sheet
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.25)) {
            offset.height = height
            showBackground = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            CUSheet.clearAll()
        }
    }
}
