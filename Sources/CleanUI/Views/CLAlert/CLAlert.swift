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
import SwiftPlus

/// This is the main Alert wrapper
internal struct CLAlert<Content: View>: View {
    
    var content: Content
    @StateObject private var model: ViewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if model.isShowing {
                    Color.black
                        .opacity(0.20)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            model.close()
                        }
                    
                    VStack(spacing: 0) {
                        content
                    }
                    .frame(width: Double(geometry.size.width - 64).maxValue(500))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.alert)
                    )
                    .padding(16)
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .onLoad {
            model.didLoad()
        }
    }
}

internal extension CLAlert {
    class ViewModel: ObservableObject {
        
        @Published var isShowing: Bool = false
        
        func didLoad() {
            
            // Show the alert with animation
            withAnimation(Animation.easeInOut(duration: 0.25)) {
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
}
